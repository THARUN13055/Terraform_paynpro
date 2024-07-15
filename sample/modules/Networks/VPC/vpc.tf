#VPC
resource "aws_vpc" "paynpro" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge({
    Name = var.vpc_name
  },var.additional_tags)
}