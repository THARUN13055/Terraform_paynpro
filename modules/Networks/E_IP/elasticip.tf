resource "aws_eip" "nat_eip" {
  domain = var.domain
  tags = {
    Name = "NAT Gateway us-east-1a"
  }
  tags_all = var.additional_tags
}   