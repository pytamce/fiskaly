variable "cluster_name" {
  type        = string
  description = "value of the EKS cluster name"
}

variable "eks_version" {
  type        = string
  default     = "1.31"
  description = "EKS version"
}

variable "tags" {
  type = map(string)
  default = {
    terraform  = "true"
    kubernetes = "demo-eks-cluster"
  }
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type to be used for worker nodes"
  default = "t3.medium"
}

variable "ami_type" {
  description = "AMI type for worker nodes. Please check documentation for availability AMI vs REGION"
  default = "AL2023_ARM_64_STANDARD"
}

variable "worker_node_group_name" {
  description = "Name used for Worker nodes"
  default = "eks-node-group"
}




