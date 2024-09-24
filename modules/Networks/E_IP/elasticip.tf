# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = var.domain
  tags = {
    Name = "NAT Gateway ap-south-1"
  }
  tags_all = var.additional_tags
}

# Elastic IP for Scanner
resource "aws_eip" "scanner_eip" {
  domain = "vpc"
  tags = {
    Name = "Scanner ap-south-1"
  }
  tags_all = var.additional_tags
}

# Elastic IP for Bastion Host
resource "aws_eip" "bastion_eip" {
  domain = "vpc"
  tags = {
    Name = "Bastion ap-south-1"
  }
  tags_all = var.additional_tags
}