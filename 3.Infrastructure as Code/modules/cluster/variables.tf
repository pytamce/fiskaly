variable "cluster_name" {
type = string
description = "value of the EKS cluster name"
}

variable "eks_version" {
type = string
default = "1.31"
description = "EKS version"
}

variable "tags" {
type = map(string)
default = {
    terraform  = "true"
    kubernetes = "demo-eks-cluster"
}
}



