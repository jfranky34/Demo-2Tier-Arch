

module "ec2_docker_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.ENV}-ec2-docker-sg"
  description = "Security group for ec2_docker_server"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}


module "db_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.ENV}-db-sg"
  description = "Security group for db_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_with_source_security_group_id = [
    {
      description              = "ec2_db access"
      rule                     = "mysql-tcp"
      source_security_group_id = module.ec2_docker_sg.this_security_group_id
    }
  ]
  egress_rules = ["all-all"]
}