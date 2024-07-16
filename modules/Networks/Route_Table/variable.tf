variable "vpc_id" {
  type = string
}

variable "internet_gateway_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}

variable "subnet_map" {
  type = map(string)
}

variable "additional_tags" {
  type = map(string)
}