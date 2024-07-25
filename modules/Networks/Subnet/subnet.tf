#Subnets
resource "aws_subnet" "subnets" {
  for_each          = var.subnet_map
  vpc_id            = var.vpc_id
  cidr_block        = each.key
  availability_zone = each.value
  map_public_ip_on_launch = index(keys(var.subnet_map), each.key) < 2
  tags = {
    Name = index(keys(var.subnet_map), each.key) < 2 ? "public${index(keys(var.subnet_map), each.key)}" : "private${index(keys(var.subnet_map), each.key)}"
  }
  tags_all = var.additional_tags
}