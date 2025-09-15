variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "AWS region"
}

variable "availability_zones"{
type = list(string)
default = ["us-east-1a", "us-east-1b"]
description = "List of AZs. Limit only to 1a and 1b" 
}


variable "cidr_block" {
type = string
default = "10.10.0.0/16"
}

variable "tags" {
type = map(string)
default = {
    terraform  = "true"
    kubernetes = "demo-eks-cluster"
}
description = "Tags to apply to all resources"
}

variable "eks_version" {
type = string
default = "1.31"
description = "EKS version"
}

variable "cluster_name" {
type = string
default = "demo-eks-cluster"
description = "value of the EKS cluster name"
}


