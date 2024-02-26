#Create VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.PROJECT-NAME}-vpc"
  }
}

#Create Internat gateway
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.PROJECT-NAME}-vpc"
  }
}
# Data availability zone
data "aws_availability_zones" "available" {}


#Create Two public subnet

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.public-subnet-1
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "pub-sub1"
    "kubernetes.io/cluster/${var.PROJECT-NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

#Public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.public-subnet-2
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "pub-sub2"
    "kubernetes.io/cluster/${var.PROJECT-NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

#Public route table

resource "aws_route_table" "eks-public-route-table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }


  tags = {
    Name = "${var.PROJECT-NAME}-pub_rt"
  }
}

resource "aws_route_table_association" "pub_rt_a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.eks-public-route-table.id
}
resource "aws_route_table_association" "pub_rt_b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.eks-public-route-table.id
}
#Private subnet 1

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.private-subnet-1
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "prv-sub1"
    "kubernetes.io/cluster/${var.PROJECT-NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

#Private subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.private-subnet-2
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "pub-sub2"
    "kubernetes.io/cluster/${var.PROJECT-NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}
