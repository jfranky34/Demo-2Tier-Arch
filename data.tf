
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_key_pair" "ec2_docker_key" {
  key_name = "ec2-docker"
}
