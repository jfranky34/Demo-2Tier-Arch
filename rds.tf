
### RDS

module "db_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env}-db-sg"
  description = "Security group for db_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_with_source_security_group_id = [
    {
      description              = "ec2_db access"
      rule                     = "mysql-tcp"
      source_security_group_id = module.ec2_ext_sg.security_group_id
    }
  ]
  egress_rules = ["all-all"]
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "${var.env}-rds"

  engine                       = "mysql"
  engine_version               = "8.0.20"
  instance_class               = "db.t2.micro"
  allocated_storage            = 30

  name     = "${var.env}rds"
  username = "fmdbuser"
  password = var.fmdemo_rdsdb_pass
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.db_sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  tags = {
    project = "${var.env}-rds"
  }

  subnet_ids = data.aws_subnet_ids.all.ids

  family                    = "mysql8.0"
  major_engine_version      = "8.0"
  final_snapshot_identifier = "${var.env}-db-mysql"
  deletion_protection       = false

}