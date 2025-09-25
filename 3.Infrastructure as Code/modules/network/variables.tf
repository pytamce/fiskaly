variable "availability_zones" {
  type        = list(string)
  description = "List of AZs.[e.g. \"us-east-1a\", \"us-east-1b\"]"
  default     = []
}


variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "cluster_name" {
  type        = string
  description = "value of the EKS cluster name"
}

variable "az_count" {
  type = number
  description = "Number of availability zones to create subnets in"
  default = 2
}


