
variable "env" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "fmdemo"
}


variable "ami" {
    type = map
    default = {
        us-east-1 = "ami-04505e74c0741db8d"
    }
}

variable "aws_region" {
    type        = string
    default     = "us-east-1"
}


variable "fmdemo_rdsdb_pass" {
    default = "fmdbPass12345"
}

