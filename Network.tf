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
  # depends_on = [ module.vpc ]
}

module "internet_gateway" {
  source                = "./modules/Networks/IGW"
  vpc_id                = module.vpc.vpc_ids
  IGW_Public_route_name = "paynpro-igw"
  additional_tags       = local.tags
  # depends_on = [ module.vpc ]
}

module "elastic_ip" {
  source          = "./modules/Networks/E_IP"
  domain          = "vpc"
  additional_tags = local.tags
  # depends_on = [ module.vpc ]
}

module "nat_gateway" {
  source          = "./modules/Networks/NAT"
  elastic_ip_nat  = module.elastic_ip.eip_ids
  subnet_id       = module.subnets.subnet_ids["10.0.2.0/24"]
  additional_tags = local.tags
  # depends_on = [ module.vpc, module.subnets ]
}

module "route_table" {
  source              = "./modules/Networks/Route_Table"
  vpc_id              = module.vpc.vpc_ids
  internet_gateway_id = module.internet_gateway.internet_gateway_ids
  nat_gateway_id      = module.nat_gateway.privateNat_ids
  subnet_map          = local.subnet_map
  additional_tags     = local.tags
  # depends_on = [ module.vpc, module.subnets, module.internet_gateway, module.nat_gateway ]
}

module "security_group_Loadbalancer" {
  source = "./modules/Networks/Security_Group"

  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    loadbalancer_sg = {
      name        = "Loadbalancer"
      description = "Security group for Loadbalancer"

      ingress = [
        {
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        }
      ]

      tags = {
        Name = "Loadbalancer"
      }
    }
  }
}
module "security_group_Webserver" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    webserver_sg = {
      name        = "Webserver"
      description = "Security group for Webserver"


      ingress = [
        {
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Loadbalancer.security_groups_ingress_ids
        }
      ]

      tags = {
        Name = "Webserver"
      }
    }
  }
}

module "security_group_Appserver" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    appserver_sg = {
      name        = "AppServer"
      description = "Security group for AppServer"


      ingress = [
        {
          from_port       = 5000
          to_port         = 5000
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Webserver.security_groups_ingress_ids
        },
        {
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Webserver.security_groups_ingress_ids
        }
      ]

      tags = {
        Name = "AppServer"
      }
    }
  }
}
module "security_group_DBServer" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    dbserver_sg = {
      name        = "DBServer"
      description = "Security group for DBServer"


      ingress = [
        {
          from_port       = 3306
          to_port         = 3306
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Appserver.security_groups_ingress_ids
        }
      ]

      tags = {
        Name = "DBServer"
      }
    }
  }
  # depends_on = [ module.vpc, module.subnets, module.internet_gateway, module.nat_gateway ]
}
