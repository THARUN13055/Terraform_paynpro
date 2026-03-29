# OpenVPN Security Group
module "security_group_OpenVPN" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = moudle.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    openvpn_sg = {
      name        = "openvpn"
      description = "Security group for OpenVPN"
      ingress = [
        {
          from_port       = 22
          to_port         = 22
          description     = "secure ssh connection"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port      = 1194
          to_port        = 1194
          description    = "openvpn connection"
          protocol       = "udp"
          cidr_blocks    = ["0.0.0.0/0"]
          security_group = null
        },
        {
          from_port      = 943
          to_port        = 943
          description    = "openvpn UI admin connection"
          protocol       = "tcp"
          cidr_blocks    = ["0.0.0.0/0"]
          security_group = null
        }
      ]
      tags = {
        Name = "openvpn"
      }
    }
  }
}

# DataBase Security Group MYSQL
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
          description     = "Java ASG connection"
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_JavaASG.security_groups_ingress_ids
        },
        {
          from_port       = 3306
          to_port         = 3306
          description     = "PHP connection"
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_php.security_groups_ingress_ids
        }
      ]
      tags = {
        Name = "DBServer"
      }
    }
  }
}

# Main WebServer Security Group
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
          description     = "https connection"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port       = 22
          to_port         = 22
          description     = "connect only through OpenVPN"
          protocol        = "ssh"
          cidr_blocks     = null
          security_groups = module.security_group_OpenVPN.security_groups_ingress_ids
        }
      ]

      tags = {
        Name = "Webserver"
      }
    }
  }
}

# Java Loadbalancer Security Group
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
          description     = "https connection"
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Webserver.security_groups_ingress_ids
        }
      ]

      tags = {
        Name = "Loadbalancer"
      }
    }
  }
}

# Java ASG Security Group
module "security_group_JavaASG" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    auto_scaling_group_sg = {
      name        = "JavaASG"
      description = "Security group for JavaASG"
      ingress = [
        {
          from_port       = 443
          to_port         = 443
          description     = "https connection to Loadbalancer"
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Loadbalancer.security_groups_ingress_ids
        },
        {
          from_port       = 22
          to_port         = 22
          description     = "connect only through OpenVPN"
          protocol        = "ssh"
          cidr_blocks     = null
          security_groups = module.security_group_OpenVPN.security_groups_ingress_ids
        }
      ]
      tags = {
        name = "JavaASG"
      }
    }
  }
}


# PHP Security Group
module "security_group_php" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    php_sg = {
      name        = "phpServer"
      description = "Security group for phpServer"
      ingress = [
        {
          from_port       = 443
          to_port         = 443
          description     = "https connection to Webserver"
          protocol        = "tcp"
          cidr_blocks     = null
          security_groups = module.security_group_Webserver.security_groups_ingress_ids
        },
        {
          from_port       = 22
          to_port         = 22
          description     = "connect only through OpenVPN"
          protocol        = "ssh"
          cidr_blocks     = null
          security_groups = module.security_group_OpenVPN.security_groups_ingress_ids
        }
      ]

      tags = {
        Name = "phpServer"
      }
    }
  }
}

# Scanner Security Group
module "security_group_scanner" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    scanner_sg = {
      name        = "scanner"
      description = "Security group for scanning DJ Dependency Checker"
      ingress = [
        {
          from_port       = 8080
          to_port         = 8080
          description     = "DefectDojo"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port       = 8081
          to_port         = 8081
          description     = "Nexus"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port       = 8085
          to_port         = 8085
          description     = "Nexus docker registry"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port       = 9000
          to_port         = 9000
          description     = "SonarQube"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port       = 22
          to_port         = 22
          description     = "connect only through OpenVPN"
          protocol        = "ssh"
          cidr_blocks     = null
          security_groups = module.security_group_OpenVPN.security_groups_ingress_ids
        }
      ]
      tags = {
        Name = "scanner"
      }
    }
  }
}

# Monitoring Security Group

module "security_group_monitoring" {
  source          = "./modules/Networks/Security_Group"
  vpc_id          = module.vpc.vpc_ids
  additional_tags = local.tags
  security_groups = {
    monitoring_sg = {
      name        = "Monitoring"
      description = "Security group for monitoring using Grafana"
      ingress = [
        {
          from_port       = 3000
          to_port         = 3000
          description     = "Grafana"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        },
        {
          from_port       = 8086
          to_port         = 8086
          description     = "InfluxDB"
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = null
        }
      ]
      tags = {
        Name = "Monitoring"
      }
    }
  }
}