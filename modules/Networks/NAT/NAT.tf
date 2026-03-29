resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.elastic_ip_nat
  subnet_id     = var.subnet_id

  tags = {
    Name = "Private_NAT"
  }
  tags_all = var.additional_tags
}