module "vpc" {
  source         = "./module/vpc"
}

# Create DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = []

  tags = {
    Name = "My DB subnet group"
  }
}

# Create RDS Instance
# Mysql instance


