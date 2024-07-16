output "vpc_ids" {
  value = module.vpc.vpc_ids
}

output "subnet_ids" {
  value = module.subnets.subnet_ids
}

output "subnet_ids_index" {
  value = module.subnets.subnet_map
}

