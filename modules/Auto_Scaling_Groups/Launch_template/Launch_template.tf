resource "aws_launch_template" "web_launch_template" {
  name = var.launch_template_name

  block_device_mappings {
    device_name = var.ebs_device_name

    ebs {
      volume_type           = var.volume_type
      volume_size           = var.volume_size
      encrypted             = var.ebs_encrypted
      delete_on_termination = var.delete_on_termination
      iops                  = var.iops
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = true

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  image_id = var.image_id

  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  instance_market_options {
    market_type = var.market_type
  }

  instance_type = var.instance_type

  key_name = var.key_pair_name

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

  placement {
    availability_zone = var.availability_zone
  }

  vpc_security_group_ids = var.security_groups

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "paynpro-webserver",
    }
  }

  lifecycle {
    create_before_destroy = false
  }
}