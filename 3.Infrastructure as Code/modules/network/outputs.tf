output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.eks-cluster-vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.eks-cluster-vpc.cidr_block
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = values(aws_subnet.private-subnet)[*].id
}