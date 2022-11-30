resource "aws_db_option_group" "default" {
  name = var.opt-grp-name
  engine_name = var.engine
  major_engine_version = var.engine_version
  tags = var.tags
}


resource "aws_db_parameter_group" "default" {
  name = var.pg-name
  family = var.family
  description = "Parameter group for mysql 5.7"
  tags = var.tags

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
