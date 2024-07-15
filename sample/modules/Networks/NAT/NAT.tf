resource "aws_nat_gateway" "nat_gateway" {
  for_each      = { for k, v in aws_subnet.subnets : k => v if k == keys(var.subnet_map)[0] }
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "Public_NAT"
  }
}