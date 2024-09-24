output "nat_eip_ids" {
  value = aws_eip.nat_eip.id
}

output "scanner_eip_ids" {
  value = aws_eip.scanner_eip.id
}

output "bastion_eip_ids" {
  value = aws_eip.bastion_eip.id
}

