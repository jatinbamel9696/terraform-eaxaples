variable "opt-grp-name-mysql" {
  description = "the name of the option group"
  type        = string
  default     = "opt-grp-mysql"
}

variable "engine-mysql" {
  description = "Database engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version-mysql" {
  description = "Database engine version"
  type        = string
  default     = "5.7"
}

variable "tags" {
  description = "tags"
  type        = map(string)
  default = {
    "env" = "test"
  }
}

variable "pg-name-mysql" {
  description = "Parameter group name"
  type        = string
  default     = "pg-mysql"
}

variable "family-mysql" {
  description = "Parameter group family"
  type        = string
  default     = "mysql5.7"
}


#oracle

variable "opt-grp-name-oracle" {
  description = "the name of the option group"
  type        = string
  default     = "opt-grp-oracle"
}

variable "engine-oracle" {
  description = "Database engine type"
  type        = string
  default     = "oracle-ee"
}

variable "engine_version-oracle" {
  description = "Database engine version"
  type        = string
  default     = "19"
}

variable "pg-name-oracle" {
  description = "Parameter group name"
  type        = string
  default     = "pg-oracle"
}

variable "family-oracle" {
  description = "Parameter group family"
  type        = string
  default     = "oracle-ee-19"
}

variable "sg_name" {
  description = "name for subnet group"
  type        = string
  default     = "test-subnet-grp"
}

variable "subnet_ids" {
  description = "vpc subnet ids"
  type        = list(string)
  default     = ["subnet-099ef5559161df2d5", "subnet-0a4f47654a82de7de"]
}



variable "audit_sys_operations" {
  type    = bool
  default = true
}


variable "parameters-mysql" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default = [ {
    "name" = "character_set_client"
    "value" = "utf8mb4"
  },
  {
    name = "character_set_server"
    value = "utf8mb4"
  }
   ]
  #default     = []
}
/*
variable "parameters-oracle" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default = [ {

  }
   ]
}
*/

variable "options" {
  description = "A list of Options to apply"
  type        = any
  default     = []
}

