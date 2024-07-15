output "subnet_ids" {
  value = {for keys,subnet in aws_subnet.subnets : "${keys}" => "${subnet.id}"}
}
