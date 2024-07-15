resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "NAT Gateway us-east-1a"
  }
}   