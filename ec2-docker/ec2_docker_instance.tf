# module "fmdemo-vpc" {
#     source      = "../module/vpc"

#     ENVIRONMENT = var.ENV
#     AWS_REGION  = var.AWS_REGION
# }


module "fmdemo-rds" {
    source      = "../module/rds"

    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet = var.vpc_private_subnet
    vpc_id = var.vpc_id
}


data "aws_key_pair" "ec2_docker_key" {
  key_name = "ec2-docker"
}


resource "aws_security_group" "ec2_docker_sg"{
  tags = {
    Name = "${var.ENV}-ec2-docker-sg"
  }
  
  name          = "${var.ENV}-ec2-docker-sg"
  description   = "Security group for EC2 docker server"
  vpc_id        = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.SSH_CIDR_EC2_DOCKER}"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2-docker-instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.INSTANCE_TYPE
  security_groups = [aws_security_group.ec2_docker_sg.id]
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
    project = "${var.ENV}-ec2-docker"
  }
}

## Outputs ##
output "instance_id" {
  description = "The EC2 Instance Id"
  value = aws_instance.ec2-docker-instance.id
}
