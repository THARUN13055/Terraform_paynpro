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

variable "availability_zones" {
  type = list(string)
}