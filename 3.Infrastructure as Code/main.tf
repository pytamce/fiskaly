# Deploy VPC & Subnets & IGW & NATGW & Routes
module "network" {
  source             = "./modules/network"
  cluster_name       = var.cluster_name
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  tags               = { Environment = var.environment_name, terraform = "true" }
}

# Deploy EKS cluster
module "cluster" {
  source       = "./modules/cluster"
  cluster_name = var.cluster_name
  private_subnet_ids = module.network.private_subnet_ids
}

# Deploy SGs
module "security" {
  source   = "./modules/security"
  vpc_id   = module.network.vpc_id
  vpc_cidr = module.network.vpc_cidr_block
}
