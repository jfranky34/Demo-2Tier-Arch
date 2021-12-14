#Output Specific to Custom VPC
output "fmdemo_vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.fmdemo_vpc.id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.fmdemo_vpc_private_subnet.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.fmdemo_vpc_public_subnet.id
}
