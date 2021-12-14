
module "fmdemo-vpc" {
    source      = "./module/vpc"

    AWS_REGION  = var.AWS_REGION
}

module "fmdemo-ec2-docker" {
    source      = "./ec2-docker"

    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet1 = module.fmdemo-vpc.private_subnet1_id
    vpc_private_subnet2 = module.fmdemo-vpc.private_subnet2_id
    vpc_id = module.fmdemo-vpc.fmdemo_vpc_id
    vpc_public_subnet1 = module.fmdemo-vpc.public_subnet1_id
    vpc_public_subnet2 = module.fmdemo-vpc.public_subnet2_id

}

#Define Provider
provider "aws" {
  region = var.AWS_REGION
}

# Outputs #

output "rds_db_endpoint" {
  value = aws_db_instance.fmdemo-rds.endpoint
}