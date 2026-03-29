variable "subnet_map" {
  type = map(string)
}

variable "additional_tags" {
  type = map(any)
}

variable "vpc_id" {
  type = string
}
