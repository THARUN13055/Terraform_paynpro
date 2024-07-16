output "security_groups_ingress_ids" {
  value = [ for sgid in aws_security_group.security_groups_ingress : sgid.id]
}