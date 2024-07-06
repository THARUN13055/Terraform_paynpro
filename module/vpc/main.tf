#VPC

resource "aws_vpc" "paynpro" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name,

  }
}

#Subnets

resource "aws_subnet" "subnets" {
  for_each                = var.subnet_map
  vpc_id                  = aws_vpc.paynpro.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = index(keys(var.subnet_map), each.key) < 2
  tags = {
    Name = index(keys(var.subnet_map), each.key) < 2 ? "public${index(keys(var.subnet_map), each.key)}" : "private${index(keys(var.subnet_map), each.key)}"
  }
  depends_on = [
    aws_vpc.paynpro
  ]
}

#route Tables

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

#Route Tables Associations

resource "aws_route_table_association" "public_route_table_association" {
  for_each       = { for k, v in aws_subnet.subnets : k => v if k == keys(var.subnet_map)[0] || k == keys(var.subnet_map)[1] }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
  depends_on = [
    aws_vpc.paynpro,
    aws_subnet.subnets,
    aws_route_table.public
  ]

}

resource "aws_route_table_association" "private_route_table_association" {
  for_each       = { for k, v in aws_subnet.subnets : k => v if index(keys(var.subnet_map), k) >= 2 }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
  depends_on = [
    aws_vpc.paynpro,
    aws_subnet.subnets,
    aws_route_table.private
  ]
}

# #Internet Gateway

resource "aws_internet_gateway" "IGW_Public_route" {
  vpc_id = aws_vpc.paynpro.id
  tags = {
    Name = "Public_IGW"
  }
  depends_on = [
    aws_vpc.paynpro
  ]
}

#Internet Gateway Attachment

resource "aws_internet_gateway_attachment" "igw_attachment" {
  internet_gateway_id = aws_internet_gateway.IGW_Public_route.id
  vpc_id              = aws_vpc.paynpro.id
  depends_on = [
    aws_vpc.paynpro,
    aws_internet_gateway.IGW_Public_route
  ]
}

# Elastic IP

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "NAT Gateway EIP"
  }
}

#NAT Gateway

resource "aws_nat_gateway" "nat_gateway" {
  for_each      = { for k, v in aws_subnet.subnets : k => v if k == keys(var.subnet_map)[0] }
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = each.value.id

  tags = {
    Name = "Public_NAT"
  }
  depends_on = [
    aws_vpc.paynpro,
    aws_subnet.subnets,
    aws_eip.nat_eip
  ]
}

#Create Security Group with Ingress Rules
resource "aws_security_group" "loadbalancer_sg" {
  name        = "Loadbalancer"
  description = "Security group for Loadbalancer"
  vpc_id      = aws_vpc.paynpro.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Loadbalancer"
  }
  depends_on = [ 
    aws_vpc.paynpro
   ]
}

resource "aws_security_group" "webserver_sg" {
  name        = "Webserver"
  description = "Security group for Webserver"
  vpc_id      = aws_vpc.paynpro.id

  ingress {
    from_port            = 443
    to_port              = 443
    protocol             = "tcp"
    security_groups      = [aws_security_group.loadbalancer_sg.id]
  }

  tags = {
    Name = "Webserver"
  }
  depends_on = [ 
    aws_vpc.paynpro,
    aws_security_group.loadbalancer_sg
   ]
}

resource "aws_security_group" "appserver_sg" {
  name        = "AppServer"
  description = "Security group for AppServer"
  vpc_id      = aws_vpc.paynpro.id

  ingress {
    from_port            = 5000
    to_port              = 5000
    protocol             = "tcp"
    security_groups      = [aws_security_group.webserver_sg.id]
  }

  ingress {
    from_port            = 8000
    to_port              = 8000
    protocol             = "tcp"
    security_groups      = [aws_security_group.webserver_sg.id]
  }

  tags = {
    Name = "AppServer"
  }
  depends_on = [ 
    aws_vpc.paynpro,
    aws_security_group.webserver_sg,
    aws_security_group.dbserver_sg
   ]
}

resource "aws_security_group" "dbserver_sg" {
  name        = "DBServer"
  description = "Security group for DBServer"
  vpc_id      = aws_vpc.paynpro.id

  ingress {
    from_port            = 3306
    to_port              = 3306
    protocol             = "tcp"
    security_groups      = [aws_security_group.appserver_sg.id]
  }

  tags = {
    Name = "DBServer"
  }
  depends_on = [
    aws_vpc.paynpro,
    aws_security_group.appserver_sg
  ]
}

# resource "aws_security_group" "security_group" {
#   for_each = var.security_group_rules

#   name        = each.value.name
#   description = each.value.description

#   dynamic "ingress" {
#     for_each = each.value
#     content {
#       from_port   = ingress.value.from_port
#       to_port     = ingress.value.to_port
#       protocol    = ingress.value.protocol
#       cidr_blocks = ingress.value.cidr_blocks != null ? ingress.value.cidr_blocks : []
#       #security_groups = ingress.value.source_security_group_id != null ? [ingress.value.source_security_group_id] : []
#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }