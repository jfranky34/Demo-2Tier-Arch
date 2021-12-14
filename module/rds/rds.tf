
#Call VPC Module First to get the Subnet IDs
# module "fmdemo-vpc" {
#     source      = "../vpc"

#     ENVIRONMENT = var.ENVIRONMENT
#     AWS_REGION  = var.AWS_REGION
# }

#Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "fmdemo-rds-subnet-group" {

    name          = "${var.ENV}-fmdemo-db-sbnet"
    description   = "Allowed subnets for DB cluster instances"
    subnet_ids    = [
      "${var.vpc_private_subnet1}",
      "${var.vpc_private_subnet2}",
    ]
    tags = {
        Name         = "${var.ENV}-fmdemo-db-subnet"
    }
}

#Define Security Groups for RDS Instances
resource "aws_security_group" "fmdemo-rds-sg" {

  name = "${var.ENV}-rds-sg"
  description = "Security Group for RDS database"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.RDS_CIDR}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "${var.ENV}-rds-sg"
   }
}

resource "aws_db_instance" "fmdemo-rds" {
  identifier = "${var.ENV}-rds"
  allocated_storage = var.FMDEMO_RDS_ALLOCATED_STORAGE
  storage_type = "gp2"
  engine = var.FMDEMO_RDS_ENGINE
  engine_version = var.FMDEMO_RDS_ENGINE_VERSION
  instance_class = var.DB_INSTANCE_CLASS
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  publicly_accessible = var.PUBLICLY_ACCESSIBLE
  username = var.FMDEMO_RDS_USERNAME
  password = var.FMDEMO_RDS_PASSWORD
  vpc_security_group_ids = [aws_security_group.fmdemo-rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.fmdemo-rds-subnet-group.name
  multi_az = "false"
}

## Outputs ##
output "rds_prod_endpoint" {
  value = aws_db_instance.fmdemo-rds.endpoint
}