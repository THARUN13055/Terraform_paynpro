resource "aws_internet_gateway" "IGW_Public_route" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.IGW_name
  }
  depends_on = [
    aws_vpc.paynpro
  ]
}

#Internet Gateway Attachment

resource "aws_internet_gateway_attachment" "igw_attachment" {
  internet_gateway_id = aws_internet_gateway.IGW_Public_route.id
  vpc_id              = var.vpc_id
}