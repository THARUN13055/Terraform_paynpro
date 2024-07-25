module "db_subnet_group" {
    source = "./modules/Database/subnet_group"
  db_subnet_group_name = "db_subnet_group"
  list_of_subnet_ids = [
    module.subnets.subnet_ids["10.0.5.0/24"],
    module.subnets.subnet_ids["10.0.6.0/24"]
  ]
  additional_tags = local.tags
}


module "mysql_instance" {
  source = "./modules/Database/Mysql_database"
  engine = "mysql"
  engine_version = "8.0.35"
  storage_type = "gp2"
  preferred_instance_classes = ["db.t3.micro","db.t3.small"]
  db_subnet_group_name = module.db_subnet_group.db_subnet_group_ids
  identifier = "mysql-instance"
  username = "admin"
  # kms_key_id = local.kms_key_arn
  db_security_group_ids = module.security_group_DBServer.security_groups_ingress_ids
  license_model = "general-public-license"
  port = 3306
  additional_tags = local.tags
  
}
