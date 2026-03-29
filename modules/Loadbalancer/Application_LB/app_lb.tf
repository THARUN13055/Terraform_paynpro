resource "aws_lb" "app_lb" {
  name                       = var.lb_name
  internal                   = false
  load_balancer_type         = var.lb_type
  security_groups            = var.security_groups_id
  subnets                    = var.subnet_ids
  enable_deletion_protection = true
  tags_all                   = var.additional_tags
}

