
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


variable "vpc_private_subnet" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}
