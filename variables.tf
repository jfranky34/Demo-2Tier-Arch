
variable "env" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "fmdemo"
}

variable "aws_region" {
    type        = string
    default     = "us-east-1"
}


variable "fmdemo_rdsdb_pass" {
    default = "fmdbPass12345"
}

