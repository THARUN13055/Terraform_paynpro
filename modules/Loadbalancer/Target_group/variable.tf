variable "target_group_name" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "additional_tags" {
  type = map(string)
}