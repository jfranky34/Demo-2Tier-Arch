
variable "SSH_CIDR_EC2_DOCKER" {
    type = string
    default = "0.0.0.0/0"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}


variable "ENV" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "fmdemo"
}


variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-04505e74c0741db8d"
        us-east-2 = "ami-0fb653ca2d3203ac1"
        us-west-2 = "ami-0892d3c7ee96c0bf7"
        eu-west-1 = "ami-08ca3fed11864d6bb"
    }
}

variable "AWS_REGION" {
    type        = string
    default     = "us-east-1"
}


variable "vpc_id" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}


variable "vpc_private_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}


variable "vpc_public_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_public_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}