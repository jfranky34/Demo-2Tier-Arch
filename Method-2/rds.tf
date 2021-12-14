
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "${var.ENV}-rds"

  engine                       = "mysql"
  engine_version               = "8.0.20"
  instance_class               = "db.t2.micro"
  allocated_storage            = 30
  storage_encrypted            = true
  performance_insights_enabled = false

  name     = "${var.ENV}rds"
  username = "fmdbuser"
  create_random_password = true
  random_password_length = 12
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.db_sg.this_security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  tags = {
    project = "${var.ENV}-rds"
  }

  subnet_ids = data.aws_subnet_ids.all.ids

  family                    = "mysql8.0"
  major_engine_version      = "8.0"
  final_snapshot_identifier = "${var.ENV}-db-postgres"
  deletion_protection       = false

}