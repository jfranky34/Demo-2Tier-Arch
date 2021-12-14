# Provider
provider "aws" {
  region     = var.AWS_REGION
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Main  vpc
resource "aws_vpc" "fmdemo_vpc" {
  cidr_block       = var.FMDEMO_VPC_CIDR_BLOCK

  tags = {
    Name = "${var.ENV}-vpc"
  }
}

# Public subnets

#public Subnet 1
resource "aws_subnet" "fmdemo_vpc_public_subnet" {
  vpc_id     = aws_vpc.fmdemo_vpc.id
  cidr_block = var.FMDEMO_VPC_PUBLIC_SUBNET_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.ENV}-vpc-public-subnet"
  }
}

# private subnet
resource "aws_subnet" "fmdemo_vpc_private_subnet" {
  vpc_id     = aws_vpc.fmdemo_vpc.id
  cidr_block = var.FMDEMO_VPC_PRIVATE_SUBNET_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.ENV}-vpc-private-subnet"
  }
}

# internet gateway
resource "aws_internet_gateway" "fmdemo_igw" {
  vpc_id = aws_vpc.fmdemo_vpc.id

  tags = {
    Name = "${var.ENV}-vpc-internet-gateway"
  }
}


# Route Table for public Architecture
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.fmdemo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fmdemo_igw.id
  }

  tags = {
    Name = "${var.ENV}-public-route-table"
  }
}

# Route Table association with public subnet
resource "aws_route_table_association" "to_public_subnet" {
  subnet_id      = aws_subnet.fmdemo_vpc_public_subnet.id
  route_table_id = aws_route_table.public.id
}



