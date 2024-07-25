variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "launch_template_id" {
  type = number
}

variable "vpc_zone_identifier" {
  type = list(string)
}