variable "launch_template_name" {
  type = string
}

variable "key_pair_name" {
  type    = string
  default = "Mumbai_paynpro"
}

variable "instance_type" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}


variable "image_id" {
  type = string
}

variable "monitoring_enabled" {
  type = bool
}

variable "additional_tags" {
  type = map(string)
}