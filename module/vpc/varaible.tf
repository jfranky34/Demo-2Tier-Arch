
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


