resource "aws_launch_template" "web_launch_template" {
  name                                 = var.launch_template_name
  image_id                             = var.image_id
  disable_api_stop                     = true
  disable_api_termination              = true
  ebs_optimized                        = true
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  key_name                             = var.key_pair_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = var.monitoring_enabled
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
  }

  tags_all = var.additional_tags
}