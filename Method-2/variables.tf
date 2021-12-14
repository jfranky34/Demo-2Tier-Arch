
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
  description = "AWS VPC Private Subnet Name"
  type        = string
  default     = ""
}

variable "vpc_public_subnet" {
  description = "AWS VPC Public Subnet Name"
  type        = string
  default     = ""
}



variable "AWS_REGION" {
    type        = string
    default     = "us-east-1"
}


variable "FMDEMO_RDS_USERNAME" {
    default = "fmdbuser"
}

variable "FMDEMO_RDS_PASSWORD" {
    default = "fmdbPass12345"
}

variable "FMDEMO_RDS_ALLOCATED_STORAGE" {
    type = string
    default = "20"
}

variable "FMDEMO_RDS_ENGINE" {
    type = string
    default = "mysql"
}

variable "FMDEMO_RDS_ENGINE_VERSION" {
    type = string
    default = "8.0.20"
}

variable "DB_INSTANCE_CLASS" {
    type = string
    default = "db.t2.micro"
}

variable "ENV" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "fmdemo"
}

variable "vpc_private_subnet" {
  description = "AWS VPC Private Subnet"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "AWS VPC Id"
  type        = string
  default     = ""
}


variable "AWS_REGION" {
    type        = string
    default     = "us-east-1"
}

variable "ENV" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "fmdemo"
}

variable "FMDEMO_VPC_CIDR_BLOCK" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "FMDEMO_VPC_PUBLIC_SUBNET_CIDR_BLOCK" {
  description = "The CIDR block for the Public Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "FMDEMO_VPC_PRIVATE_SUBNET_CIDR_BLOCK" {
  description = "The CIDR block for the Private Subnet"
  type        = string
  default     = "10.0.2.0/24"
}


