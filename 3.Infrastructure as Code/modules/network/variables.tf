variable "availability_zones"{
type = list(string)
description = "List of AZs. Limit only to 1a and 1b" 
}


variable "cidr_block" {
type = string
description = "CIDR block for the VPC"
}

variable "tags" {
type = map(string)
description = "Tags to apply to all resources"
default     = {}
}

variable "cluster_name" {
type = string
description = "value of the EKS cluster name"
}


