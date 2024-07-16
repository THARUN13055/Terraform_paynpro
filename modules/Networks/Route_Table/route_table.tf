module "subnets" {
  source = "../Subnet"
  subnet_map = var.subnet_map
  vpc_id = var.vpc_id
  additional_tags = var.additional_tags
}

#Creating the Route Table

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
  tags ={
    Name = "public-route-table"
  }
  tags_all = var.additional_tags
  # depends_on = [
  #   aws_vpc.paynpro,
  #   aws_internet_gateway.IGW_Public_route
  # ]
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "private-route-table"
  }
  tags_all = var.additional_tags
  # depends_on = [
  #   aws_vpc.paynpro,
  #   aws_nat_gateway.nat_gateway
  # ]
}

#Associated the Route Table


resource "aws_route_table_association" "public_route_table_association" {
  for_each       = { for k, v in module.subnets.subnet_map : k => v if k == keys(var.subnet_map)[0] || k == keys(var.subnet_map)[1] }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
  # depends_on = [
  #   aws_vpc.paynpro,
  #   aws_subnet.subnets,
  #   aws_route_table.public
  # ]
}

resource "aws_route_table_association" "private_route_table_association" {
  for_each       = { for k, v in module.subnets.subnet_map : k => v if index(keys(var.subnet_map), k) >= 2 }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
  # depends_on = [
  #   aws_vpc.paynpro,
  #   aws_subnet.subnets,
  #   aws_route_table.private
  # ]
}
