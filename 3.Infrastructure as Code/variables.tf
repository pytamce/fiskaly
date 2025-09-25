variable "environment_name" {
  description = "Name of the environment"
  type        = string
}

variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type        = string
  description = "value of the EKS cluster name"
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number
  default     = 2
}
