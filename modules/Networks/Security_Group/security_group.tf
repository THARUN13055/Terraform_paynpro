#Create Security Group with Ingress Rules
resource "aws_security_group" "security_groups_ingress" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id
  tags        = merge(var.additional_tags, each.value.tags)

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
      protocol  = ingress.value.protocol

      cidr_blocks     = can(ingress.value.cidr_blocks) ? ingress.value.cidr_blocks : null
      security_groups = can(ingress.value.security_groups) ? ingress.value.security_groups : null
    }
  }
}
