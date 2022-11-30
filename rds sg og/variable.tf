variable "opt-grp-name" {
  description = "the name of the option group"
  type = string
  default = "test-opt-grp"
}

variable "engine" {
  description = "Database engine type"
  type = string
  default = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type = string
  default = "5.7"
}

variable "tags" {
  description = "tags"
  type = map(string)
  default = {
    "env" = "test"
  }
}

variable "pg-name" {
  description = "Parameter group name"
  type = string
  default = "test-pg"
}

variable "family" {
  description = "Parameter group family"  
  type = string
  default = "mysql5.7"
}