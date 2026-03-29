#VPC
resource "aws_vpc" "paynpro" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
  tags_all = var.additional_tags
}