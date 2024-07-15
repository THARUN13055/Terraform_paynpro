module "vpc" {
  source = "./modules/Networks/VPC"
  vpc_name = "paynpro"
  vpc_cidr_block = "10.0.0.0/16"
  additional_tags = local.tags
}

module "subnets" {
  source = "./modules/Networks/Subnet"
  subnet_map = local.subnet_map
  vpc_id = module.vpc.vpc_ids
  additional_tags = local.tags
}

module "igw" {
  source = "./modules/Networks/IGW"
  vpc_id = module.vpc.vpc_ids
  IGW_name = "public-route-ig"
}

module "eip" {
  source = "./modules/Networks/E_IP"
  
}