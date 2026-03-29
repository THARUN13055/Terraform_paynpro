variable "load_balancer_arn" {
  type = any
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "target_group_arn" {
  type = any
}

variable "additional_tags" {
  type = map(string)
}