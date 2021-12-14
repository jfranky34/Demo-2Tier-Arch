
# output "rds_db_endpoint" {
#   description = "The connection endpoint"
#   value = module.db.db_instance_endpoint
# }

output "instance_id" {
  description = "The EC2 Instance Id"
  value = aws_instance.ec2-docker-instance.id
}
