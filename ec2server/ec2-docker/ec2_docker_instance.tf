# module "fmdemo-vpc" {
#     source      = "../module/vpc"

#     ENVIRONMENT = var.ENV
#     AWS_REGION  = var.AWS_REGION
# }

module "fmdemo-rds" {
    source      = "../module/rds"

    ENVIRONMENT = var.ENV
    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet1 = var.vpc_private_subnet1
    vpc_private_subnet2 = var.vpc_private_subnet2
    vpc_id = var.vpc_id
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

resource "aws_launch_configuration" "launch_config_ec2_docker" {
  name   = "launch-config-ec2-docker"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.INSTANCE_TYPE
  user_data = file("docker_install.sh")
  security_groups = [aws_security_group.ec2_docker_sg.id]
  key_name = "ec2-docker"
  
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}

resource "aws_autoscaling_group" "ec2_docker_asg" {
  count                     = 2
  name                      = "${var.ENV}-ec2-docker-${count.index}"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch_config_ec2_docker.name
  vpc_zone_identifier       = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
}


## Outputs ##
output "asg_output" {
  description = "The AutoScaling Group Name"
  value = aws_autoscaling_group.ec2_docker_asg.name
}
