variable "vpc_id" {
  type = string
}

variable "additional_tags" {
  type        = map(string)
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      security_groups  = list(string)
    }))
    tags        = map(string)
  }))
}