
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.paynpro.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_Public_route.id
  }
  tags = {
    Name = "public-route-table"
  }
  depends_on = [
    aws_vpc.paynpro,
    aws_internet_gateway.IGW_Public_route
  ]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.paynpro.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[keys(var.subnet_map)[0]].id
  }

  tags = {
    Name = "private-route-table"
  }
  depends_on = [
    aws_vpc.paynpro,
    aws_nat_gateway.nat_gateway
  ]
}