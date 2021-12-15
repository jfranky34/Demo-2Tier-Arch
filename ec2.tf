# EC2

resource "aws_instance" "ec2-docker-instance" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.ec2_docker_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_rds_profile.name
  
  vpc_security_group_ids = [
    module.ec2_ext_sg.security_group_id,
    module.ec2_ssh_sg.security_group_id,
  ]
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
    sudo apt install -y mysql-client
  EOF

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

  tags = {
     name = "${var.env}-ec2-docker"
  }
}
