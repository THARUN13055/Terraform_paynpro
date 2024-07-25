provider "aws" {
  region = "ap-south-1"
}

resource "random_password" "db_password" {
  length  = 32
  special = true
  override_special = "_%@'^"
}

resource "aws_db_instance" "mysql_instance" {
  allocated_storage           = 500
  auto_minor_version_upgrade  = true
  backup_retention_period     = 7
  db_subnet_group_name        = var.db_subnet_group_name
  engine                      = data.aws_rds_orderable_db_instance.mysql.engine
  engine_version              = data.aws_rds_orderable_db_instance.mysql.engine_version
  identifier                  = var.identifier
  instance_class              = data.aws_rds_orderable_db_instance.mysql.instance_class
  #kms_key_id                  = data.aws_kms_key.by_id.arn
  multi_az                    = true
  password                    = random_password.db_password.result
  storage_encrypted           = true
  username                    = var.username
  vpc_security_group_ids = var.db_security_group_ids
  license_model = var.license_model
  publicly_accessible = false
  skip_final_snapshot = false
  allow_major_version_upgrade = true
  blue_green_update {
    enabled = true
  }
  port = var.port
  tags = {
    Name = "paynpro_db"
  }
  tags_all = var.additional_tags

  timeouts {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
}

