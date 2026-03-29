# output "vpc_ids" {
#   value = module.vpc.vpc_ids
# }

# output "subnet_ids" {
#   value = module.subnets.subnet_ids
# }

# output "subnet_ids_index" {
#   value = module.subnets.subnet_map
# }

output "db_hostname" {
  description = "The hostname of the RDS instance"
  value       = module.mysql_instance.db_hostname
}

output "db_username" {
  description = "The master username for the RDS instance"
  value       = module.mysql_instance.db_username
}

output "db_password" {
  description = "The password for the RDS instance"
  value       = module.mysql_instance.db_password
  sensitive   = true
}
