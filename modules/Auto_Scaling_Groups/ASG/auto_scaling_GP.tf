resource "aws_autoscaling_group" "ASG" {
  availability_zones = var.availability_zones
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
  tag {
    key                 = "Name"
    value               = "Paynpro-ASG"
    propagate_at_launch = true
  }
}