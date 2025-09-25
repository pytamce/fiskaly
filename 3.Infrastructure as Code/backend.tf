terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket         = "terraform-state-s3-mhaluska"
    key            = "tf-eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mhaluska-S3-state"
    encrypt        = true
  }

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