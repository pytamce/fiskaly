# VPC
resource "aws_vpc" "eks-cluster-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}

# This tag is needed to join worker nodes to the control plane
locals {
  additional_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Fetch all available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Select AZs to use. Limit deployment only to 2 AZs. This value can be changed by "az_count"
locals {
  selected_azs = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, var.az_count)
}

# Public subnets
resource "aws_subnet" "public-subnet" {
  for_each = toset(local.selected_azs)

  vpc_id                  = aws_vpc.eks-cluster-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.eks-cluster-vpc.cidr_block, 8, index(local.selected_azs, each.key))
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "public-subnet-${each.key}" })
}

# Private subnets
resource "aws_subnet" "private-subnet" {
  for_each = toset(local.selected_azs)

  vpc_id                  = aws_vpc.eks-cluster-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.eks-cluster-vpc.cidr_block, 8, index(local.selected_azs, each.key) + 10)
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(var.tags, { Name = "private-subnet-${each.key}" })
}

# Internet Gateway
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-cluster-vpc.id
  tags   = merge(var.tags, { Name = "eks-igw" })
}

# Elastic IPs for NAT gateways
resource "aws_eip" "nat" {
  for_each = aws_subnet.public-subnet
  domain   = "vpc"

  tags = merge(var.tags, { Name = "nat-eip-${each.key}" })
}

# NAT Gateways (one per public subnet/AZ)
resource "aws_nat_gateway" "eks-ngw" {
  for_each      = aws_subnet.public-subnet
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(var.tags, { Name = "nat-gateway-${each.key}" })

  depends_on = [aws_internet_gateway.eks-igw]
}

# Public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.eks-cluster-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }

  tags = merge(var.tags, { Name = "public-rt" })
}

# Private route tables (one per AZ)
resource "aws_route_table" "private-rt" {
  for_each = aws_subnet.private-subnet

  vpc_id = aws_vpc.eks-cluster-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ngw[each.key].id
  }

  tags = merge(var.tags, { Name = "private-rt-${each.key}" })
}

# Public route table associations
resource "aws_route_table_association" "public-rt-assoc" {
  for_each = aws_subnet.public-subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}

# Private route table associations
resource "aws_route_table_association" "private-rt-assoc" {
  for_each = aws_subnet.private-subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rt[each.key].id
}