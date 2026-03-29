resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.list_of_subnet_ids

  tags = {
    Name = "db_subnet_group"
  }
  tags_all = var.additional_tags
}