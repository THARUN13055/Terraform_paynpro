variable "vpc_id" {
  type = string
}

variable "IGW_Public_route_name" {
  type = string
}

variable "additional_tags" {
  type = map(any)
}