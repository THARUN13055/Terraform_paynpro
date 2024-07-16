output "subnet_ids" {
  value = { for keys, subnet in aws_subnet.subnets : "${keys}" => "${subnet.id}" }
}
output "subnet_map" {
  description = "Map of subnet IDs with keys"
  value       = { for idx, subnet in aws_subnet.subnets : idx => subnet }
}