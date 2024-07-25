variable "db_subnet_group_name" {
  type        = string
}

variable "list_of_subnet_ids" {
  type = list(string)
}

variable "additional_tags" {
  type = map(string)
}