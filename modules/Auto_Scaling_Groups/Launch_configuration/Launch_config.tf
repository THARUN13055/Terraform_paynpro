resource "aws_launch_configuration" "web_launch_configuration" {
  name                                 = var.launch_configuration_name
  image_id                             = var.image_id
  ebs_optimized                        = true
  instance_type                        = var.instance_type
  key_name                             = var.key_pair_name
  security_groups                      = var.security_groups
  enable_monitoring = var.monitoring_enabled
  ebs_block_device {
    device_name = var.ebs_device_name
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = var.ebs_encrypted
    delete_on_termination = var.delete_on_termination
    iops = var.iops
  }
    lifecycle {
    create_before_destroy = true
  }
}