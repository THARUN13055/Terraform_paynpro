module "vpc" {
  source         = "./module/vpc"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_name       = "paynpro_vpc"
  subnet_map = {
    "10.0.1.0/24" = "us-east-1a", #public subnet webserver
    "10.0.2.0/24" = "us-east-1b", #public subnet webserver
    "10.0.3.0/24" = "us-east-1a", #private subnet appserver
    "10.0.4.0/24" = "us-east-1b", #private subnet appserver
    "10.0.5.0/24" = "us-east-1a", #private subnet db
    "10.0.6.0/24" = "us-east-1b", #private subnet db
  } 
  # security_group = {
  #   "Loadbalancer" = "This is a security group for loadbalancer",
  #   "Webserver" = "This is a security group for webserver",
  #   "AppServer" = "This is a security group for appserver",
  #   "DBServer"  = "This is a security group for dbserver",
  # }
  # security_group_rules = {
  #   Loadbalancer = [
  #     {
  #       from_port   = 443
  #       to_port     = 443
  #       protocol    = "tcp"
  #       cidr_blocks = ["0.0.0.0/0"]
  #     }
  #   ],
  #   Webserver = [
  #     {
  #       from_port            = 443
  #       to_port              = 443
  #       protocol             = "tcp"
  #       cidr_blocks = ["0.0.0.0/0"]
  #       #source_security_group_id = aws_security_group.security_group["Loadbalancer"].id
  #     }
  #   ],
  #   AppServer = [
  #     {
  #       from_port            = 5000
  #       to_port              = 5000
  #       protocol             = "tcp"
  #       cidr_blocks = ["0.0.0.0/0"]
  #       #source_security_group_id = aws_security_group.security_group["Webserver"].id
  #     },
  #     {
  #       from_port            = 8000
  #       to_port              = 8000
  #       protocol             = "tcp"
  #       cidr_blocks = ["0.0.0.0/0"]
  #       #source_security_group_id = aws_security_group.security_group["Webserver"].id
  #     }
  #   ],
  #   DBServer = [
  #     {
  #       from_port            = 3306
  #       to_port              = 3306
  #       protocol             = "tcp"
  #       cidr_blocks = ["0.0.0.0/0"]
  #       #source_security_group_id = aws_security_group.security_group["AppServer"].id
  #     }
  #   ]
  # }
}

