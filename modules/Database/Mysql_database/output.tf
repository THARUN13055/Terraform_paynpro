output "db_hostname" {
  value = aws_db_instance.mysql_instance.address
}

output "db_username" {
  value = var.username
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}
