variable "lb_name" {
  type = string
}

variable "lb_type" {
  type = string
}

variable "security_groups_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "additional_tags" {
  type = map(string)
}

variable "subnet_ids" {
  type = list(string)
}