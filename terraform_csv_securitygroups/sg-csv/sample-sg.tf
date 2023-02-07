
# Create Security group for Sample SG 

resource "aws_security_group" "sg" {

  name = var.sg_name

  vpc_id = var.vpc_id

  tags = merge(var.tags, {Name = "${var.sg_name}-sg"})

}

locals {
  sg_csv_file = file("${path.module}/sg.csv")
  sg_csv       = csvdecode(local.sg_csv_file)

  sg_details = flatten([

    for sg_rule in local.sg_csv : {
      rule_id     = sg_rule.rule_id
      description = sg_rule.Description
      protocol    = sg_rule.protocol
      from_port   = sg_rule.From_Port
      to_port     = sg_rule.To_Port
      cidr_blocks = split(",", sg_rule.source_cidr)
    }
  ])
}

resource "aws_security_group_rule" "sg_ingress" {
  count             = length(local.sg_details)
  security_group_id = aws_security_group.sg.id
  type              = "ingress"
  description       = "${local.sg_details[count.index].rule_id}-${local.sg_details[count.index].description}"
  protocol          = local.sg_details[count.index].protocol
  from_port         = local.sg_details[count.index].from_port
  to_port           = local.sg_details[count.index].to_port
  cidr_blocks       = local.sg_details[count.index].cidr_blocks
}

resource "aws_security_group_rule" "sg_egress" {
  type              = "egress"
  security_group_id = aws_security_group.sg.id
  description       = "SG-Egress"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
}
