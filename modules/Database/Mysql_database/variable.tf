variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "storage_type" {
  type = string
}

variable "preferred_instance_classes" {
  type = list(string)
}

variable "db_subnet_group_name" {
  type = string
}

variable "identifier" {
  type = string
}

variable "username" {
  type = string
}

# variable "kms_key_id" {
#   type        = string
# }

variable "db_security_group_ids" {
  type = list(string)
}

variable "license_model" {
  type = string
}

variable "port" {
  type = number
}

variable "additional_tags" {
  type = map(string)
}