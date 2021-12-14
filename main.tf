
#Define Provider
provider "aws" {
  region = var.AWS_REGION
}


module "fmdemo-vpc" {
    source      = "./module/vpc"

    AWS_REGION  = var.AWS_REGION
}

module "fmdemo-ec2-docker" {
    source      = "./ec2-docker"

    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet = module.fmdemo-vpc.private_subnet_id
    vpc_id = module.fmdemo-vpc.fmdemo_vpc_id
    vpc_public_subnet = module.fmdemo-vpc.public_subnet_id
}

