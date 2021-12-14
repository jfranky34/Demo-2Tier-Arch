#Output Specific to Custom VPC
output "fmdemo_vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.fmdemo_vpc.id
}

output "private_subnet1_id" {
  description = "Subnet ID"
  value       = aws_subnet.fmdemo_vpc_private_subnet_1.id
}

output "private_subnet2_id" {
  description = "Subnet ID"
  value       = aws_subnet.fmdemo_vpc_private_subnet_2.id
}

output "public_subnet1_id" {
  description = "Subnet ID"
  value       = aws_subnet.fmdemo_vpc_public_subnet_1.id
}

output "public_subnet2_id" {
  description = "Subnet ID"
  value       = aws_subnet.fmdemo_vpc_private_subnet_2.id
}