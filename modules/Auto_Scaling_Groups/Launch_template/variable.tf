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

variable "security_groups" {
  type = list(string)
}

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

variable "instance_initiated_shutdown_behavior" {
  type = string
}

variable "market_type" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "availability_zone" {
  type = string
}

variable "additional_tags" {
  type = map(string)
}

variable "monitoring_enabled" {
  type = bool
}

variable "iam_instance_profile" {
  type = string
}