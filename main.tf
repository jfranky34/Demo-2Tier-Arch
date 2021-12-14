
# main.tf
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12.0"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}


# IAM Role 
resource "aws_iam_role" "ec2_rds" {
  name = "${var.env}-ec2-rds-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    project = "${var.env}-ec2-rds-role"
  }
}

resource "aws_iam_instance_profile" "ec2_rds_profile" {
  name = "${var.env}-ec2-rds-profile"
  role = aws_iam_role.ec2_rds.name
}

resource "aws_iam_role_policy" "ec2_rds_policy" {
  name = "${var.env}-ec2-rds-policy"
  role = aws_iam_role.ec2_rds.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "rds:*",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricStatistics",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "sns:ListSubscriptions",
        "sns:ListTopics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

### EC2
data "aws_key_pair" "ec2_docker_key" {
  key_name = "ec2-docker"
}

module "ec2_docker_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env}-ec2-docker-sg"
  description = "Security group for ec2_docker_server"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

resource "aws_instance" "ec2-docker-instance" {
  ami           = lookup(var.ami, var.aws_region)
  instance_type = "t2.micro"
  security_groups = [module.ec2_docker_sg.security_group_id]
  key_name = data.aws_key_pair.ec2_docker_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_rds_profile.name
  user_data = <<-EOF
    #!/bin/bash
    set -ex

    ## Install Docker ##
    sudo apt-get update
    sudo apt-get install -y cloud-utils apt-transport-https ca-certificates curl software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo usermod -aG docker ubuntu
    sudo chmod 666 /var/run/docker.sock
    sudo apt-get install -y wget
  EOF

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

  tags = {
    project = "${var.env}-ec2-docker"
  }
}

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
      source_security_group_id = module.ec2_docker_sg.security_group_id
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
  storage_encrypted            = true
  performance_insights_enabled = false

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