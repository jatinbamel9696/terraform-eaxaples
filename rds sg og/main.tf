resource "aws_db_option_group" "option_group_mysql" {
  name                 = var.opt-grp-name-mysql
  engine_name          = var.engine-mysql
  major_engine_version = var.engine_version-mysql
  tags                 = var.tags
  
}


resource "aws_db_parameter_group" "parameter_group_mysql" {
  name        = var.pg-name-mysql
  family      = var.family-mysql
  description = "Parameter group for mysql 5.7"
  tags        = var.tags
  dynamic "parameter" {
    for_each = var.parameters-mysql
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
}

##og and pg group for oracle

resource "aws_db_option_group" "option_group_oracle" {
  name                 = var.opt-grp-name-oracle
  engine_name          = var.engine-oracle
  major_engine_version = var.engine_version-oracle
  tags                 = var.tags
}


resource "aws_db_parameter_group" "parameter_group_oracle" {
  name        = var.pg-name-oracle
  family      = var.family-oracle
  description = "Parameter group for oracle"
  tags        = var.tags
  /*dynamic "parameter" {
    for_each = var.parameters-oracle
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
    */
  }
  



resource "aws_db_subnet_group" "subnet_group" {
  name       = var.sg_name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

##security group

resource "aws_security_group" "rdssg" {
  name   = "rdssg"
  vpc_id = "vpc-06d324033a4cf18ea"
  tags   = merge(var.tags, { Name = "rds-sg" })

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}