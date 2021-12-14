
output "rds_db_endpoint" {
  value = module.fmdemo_db.db_instance_endpoint
}

output "instance_id" {
  description = "The EC2 Instance Id"
  value = aws_instance.ec2-docker-instance.id
}