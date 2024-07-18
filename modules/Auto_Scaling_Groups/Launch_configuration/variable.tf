variable "launch_configuration_name" {
  type = string
}

variable "key_pair_name" {
  type    = string
  default = "Mumbai_paynpro"
}

variable "instance_type" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

#ebs

variable "ebs_device_name" {
  type = string
}

variable "volume_type" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "ebs_encrypted" {
  type = bool
}

variable "delete_on_termination" {
  type = bool
}

variable "iops" {
  type = number
}



variable "image_id" {
  type = string
}

variable "monitoring_enabled" {
  type = bool
}
