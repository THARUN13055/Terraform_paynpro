module "Launch_template" {
  source                    = "./modules/Auto_Scaling_Groups/Launch_template"
  launch_template_name      = "paynpro-launch-template"
  key_pair_name             = "Mumbai_paynpro"
  instance_type             = "t2.micro"
  image_id                  = "ami-0ad21ae1d0696ad58"
  monitoring_enabled        = true
  security_groups           = module.security_group_Webserver.security_groups_ingress_ids
  ebs_device_name           = "/dev/xvda"
  volume_type               = "gp3"
  volume_size               = 8
  ebs_encrypted             = true
  delete_on_termination     = true
  iops                      = 2000
  instance_initiated_shutdown_behavior = "stop"
  market_type               = "spot"
  associate_public_ip_address = false
  availability_zone = "us-east-1a"
  iam_instance_profile = "paynpro-code-deployer"
}


module "Auto_Scaling_Groups" {
  source             = "./modules/Auto_Scaling_Groups/ASG"
  desired_capacity   = 2
  min_size           = 1
  max_size           = 5
  launch_template_id = module.Launch_template.launch_template_ids
  availability_zones = ["us-east-1a", "us-east-1b"]
}