terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Deploy VPC & Subnets & IGW & NATGW & Routes
module "network" {
  source             = "./modules/network"
  cidr_block         = "10.10.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  cluster_name       = "demo-eks-cluster"
  tags               = { Environment = "dev" , terraform  = "true"}
}

# Deploy EKS cluster
module "cluster" {
  source             = "./modules/cluster"
  cluster_name       = "demo-eks-cluster"
}

# Deploy SGs
module "security" {
  source             = "./modules/security"
}


