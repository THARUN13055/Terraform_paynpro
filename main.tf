module "vpc" {
  source          = "./modules/Networks/VPC"
  vpc_name        = "paynpro"
  vpc_cidr_block  = "10.0.0.0/16"
  additional_tags = local.tags
}

module "subnets" {
  source          = "./modules/Networks/Subnet"
  subnet_map      = local.subnet_map
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
}

module "internet_gateway" {
  source          = "./modules/Networks/IGW"
  vpc_id          = module.vpc.vpc_ids
  IGW_Public_route_name = "paynpro-igw"
  additional_tags = local.tags
}

module "elastic_ip" {
  source          = "./modules/Networks/E_IP"
  domain          = "vpc"
  additional_tags = local.tags
}

module "nat_gateway" {
  source          = "./modules/Networks/NAT"
  elastic_ip_nat  = module.elastic_ip.eip_ids
  subnet_id       = module.subnets.subnet_ids["10.0.2.0/24"]
  additional_tags = local.tags
}

module "route_table" {
  source              = "./modules/Networks/Route_Table"
  vpc_id              = module.vpc.vpc_ids
  internet_gateway_id = module.internet_gateway.internet_gateway_ids
  nat_gateway_id      = module.nat_gateway.privateNat_ids
  subnet_map          = local.subnet_map
  additional_tags = local.tags
}