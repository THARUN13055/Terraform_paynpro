module "Application_loadbalancer" {
  source             = "./modules/Loadbalancer/Application_LB"
  lb_name            = "Paynpro-LB"
  lb_type            = "application"
  security_groups_id = module.security_group_DBServer.security_groups_ingress_ids
  vpc_id             = module.vpc.vpc_ids
  subnet_ids         = [module.subnets.subnet_ids["10.0.1.0/24"], module.subnets.subnet_ids["10.0.2.0/24"]]
  additional_tags    = local.tags
}

module "Target_group" {
  source            = "./modules/Loadbalancer/Target_group"
  target_group_name = "Paynpro-TargetGroup"
  port              = 443
  vpc_id            = module.vpc.vpc_ids
  additional_tags   = local.tags
  protocol          = "HTTPS"
}

module "Listener" {
  source            = "./modules/Loadbalancer/Listener"
  load_balancer_arn = module.Application_loadbalancer.load_balancer_arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = local.certificate_arn
  target_group_arn  = module.Target_group.target_group_arn
  additional_tags   = local.tags
}

module "Launch_template" {
  source                      = "./modules/Auto_Scaling_Groups/Launch_Temp"
  launch_template_name        = "paynpro-launch-template"
  key_pair_name               = "Mumbai_paynpro"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  # vpc_security_group_ids = [module.security_group_Webserver.security_groups_ingress_ids,module.security_group_Webserver.security_groups_ingress_ids]
  image_id           = "ami-0ad21ae1d0696ad58"
  monitoring_enabled = true
  additional_tags    = local.tags
}

module "Auto_Scaling_Groups" {
  source             = "./modules/Auto_Scaling_Groups/ASG"
  desired_capacity   = 1
  min_size           = 1
  max_size           = 5
  launch_template_id = module.Launch_template.launch_template_ids
  availability_zones = ["us-east-1a", "us-east-1b"]
}