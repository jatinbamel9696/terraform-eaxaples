variable "vpc_id" {
  description = "VPC ID to place resolver endpoints in"
  type        = string
  default = "null"
}

variable "sg_name" {
  description = "Security group name"
  type        = string
  default = "null"
}
/*
variable "sg_id" {
  description = "Security group id"
  type        = string
}
*/
variable "tags" {
  default     = {}
  description = "Tags to apply to created resources"
  type        = map(string)
}