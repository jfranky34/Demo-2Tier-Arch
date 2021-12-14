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
