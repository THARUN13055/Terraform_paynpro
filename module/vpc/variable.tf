variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
}

variable "subnet_map" {
  type = map(string)
}

# variable "security_group" {
#   type = map(string)
# }

# variable "security_group_rules" {
#   type = map(any)
# }
