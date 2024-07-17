resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
    health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  tags_all = var.additional_tags
}