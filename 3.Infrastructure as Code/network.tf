# create VPC
resource "aws_vpc" "demo-eks-cluster-vpc" {
cidr_block       = var.cidr_block
enable_dns_hostnames = true
tags = var.tags
}

locals {
additional_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
}
}

# create private and public subnets
resource "aws_subnet" "public-subnet-1" {
vpc_id     = aws_vpc.demo-eks-cluster-vpc.id
cidr_block = cidrsubnet(var.cidr_block, 8, 10) # 10.10.10.0/24
availability_zone = var.availability_zones[0]
tags = var.tags
}

resource "aws_subnet" "public-subnet-2" {
vpc_id     = aws_vpc.demo-eks-cluster-vpc.id
cidr_block = cidrsubnet(var.cidr_block, 8, 20) # 10.10.20.0/24
availability_zone = var.availability_zones[1]
tags = var.tags
}

resource "aws_subnet" "private-subnet-1" {
vpc_id     = aws_vpc.demo-eks-cluster-vpc.id
cidr_block = cidrsubnet(var.cidr_block, 8, 110) # 10.10.110.0/24
availability_zone = var.availability_zones[0]
tags = merge( var.tags, local.additional_tags)
lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

resource "aws_subnet" "private-subnet-2" {
vpc_id     = aws_vpc.demo-eks-cluster-vpc.id
cidr_block = cidrsubnet(var.cidr_block, 8, 120)
availability_zone = var.availability_zones[1]
tags = merge( var.tags, local.additional_tags)
lifecycle {
    ignore_changes = [tags, tags_all]
  }
}

# create internet gateway
resource "aws_internet_gateway" "eks-igw" {
vpc_id = aws_vpc.demo-eks-cluster-vpc.id
tags = var.tags
}

# create elasticIP
resource "aws_eip" "eks-ngw-eip" {
domain = "vpc"
tags = var.tags
depends_on = [aws_internet_gateway.eks-igw]
}

# create NAT gateway
resource "aws_nat_gateway" "eks-ngw" {
allocation_id = aws_eip.eks-ngw-eip.id
subnet_id     = aws_subnet.public-subnet-1.id

depends_on = [aws_internet_gateway.eks-igw]
tags = var.tags
}

# create route tables and associations
resource "aws_route_table" "public-rt" {
vpc_id = aws_vpc.demo-eks-cluster-vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
}
tags = var.tags
}

resource "aws_route_table"  "private-rt" {
vpc_id = aws_vpc.demo-eks-cluster-vpc.id

route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ngw.id
}
tags = var.tags
}

resource "aws_route_table_association" "public-rt-assoc-1" {
subnet_id      = aws_subnet.public-subnet-1.id
route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-assoc-2" {
subnet_id      = aws_subnet.public-subnet-2.id
route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt-assoc-1" {
subnet_id      = aws_subnet.private-subnet-1.id
route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-rt-assoc-2" {
subnet_id      = aws_subnet.private-subnet-2.id
route_table_id = aws_route_table.private-rt.id
}