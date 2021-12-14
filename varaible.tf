
variable "ENV" {
    type    = string
    default = "fmdemo"
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
default = "us-east-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}