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
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.ENV}-vpc"
  }
}

# Public subnets

#public Subnet 1
resource "aws_subnet" "fmdemo_vpc_public_subnet_1" {
  vpc_id     = aws_vpc.fmdemo_vpc.id
  cidr_block = var.FMDEMO_VPC_PUBLIC_SUBNET1_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.ENV}-vpc-public-subnet-1"
  }
}
#public Subnet 2
resource "aws_subnet" "fmdemo_vpc_public_subnet_2" {
  vpc_id     = aws_vpc.fmdemo_vpc.id
  cidr_block = var.FMDEMO_VPC_PUBLIC_SUBNET2_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.ENV}-vpc-public-subnet-2"
  }
}

# private subnet 1
resource "aws_subnet" "fmdemo_vpc_private_subnet_1" {
  vpc_id     = aws_vpc.fmdemo_vpc.id
  cidr_block = var.FMDEMO_VPC_PRIVATE_SUBNET1_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.ENV}-vpc-private-subnet-1"
  }
}
# private subnet 2
resource "aws_subnet" "fmdemo_vpc_private_subnet_2" {
  vpc_id     = aws_vpc.fmdemo_vpc.id
  cidr_block = var.FMDEMO_VPC_PRIVATE_SUBNET2_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.ENV}-vpc-private-subnet-2"
  }
}

# internet gateway
resource "aws_internet_gateway" "fmdemo_igw" {
  vpc_id = aws_vpc.fmdemo_vpc.id

  tags = {
    Name = "${var.ENV}-vpc-internet-gateway"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "fmdemo_nat_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.fmdemo_igw]
}

# NAT gateway for private ip address
resource "aws_nat_gateway" "fmdemo_ngw" {
  allocation_id = aws_eip.fmdemo_nat_eip.id
  subnet_id     = aws_subnet.fmdemo_vpc_public_subnet_1.id
  depends_on = [aws_internet_gateway.fmdemo_igw]
  tags = {
    Name = "${var.ENV}-vpc-NAT-gateway"
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
    Name = "${var.ENV}-fmdemo-public-route-table"
  }
}

# Route table for Private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.fmdemo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.fmdemo_ngw.id
  }

  tags = {
    Name = "${var.ENV}-private-route-table"
  }
}

# Route Table association with public subnets
resource "aws_route_table_association" "to_public_subnet1" {
  subnet_id      = aws_subnet.fmdemo_vpc_public_subnet_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "to_public_subnet2" {
  subnet_id      = aws_subnet.fmdemo_vpc_public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Route table association with private subnets
resource "aws_route_table_association" "to_private_subnet1" {
  subnet_id      = aws_subnet.fmdemo_vpc_private_subnet_1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "to_private_subnet2" {
  subnet_id      = aws_subnet.fmdemo_vpc_private_subnet_2.id
  route_table_id = aws_route_table.private.id
}

