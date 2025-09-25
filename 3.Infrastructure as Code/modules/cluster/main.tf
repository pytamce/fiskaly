##### CONTROL PLANE #####

# create role for EKS cluster and policy
resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"

        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo-eks-cluster-role.name
}

# limit access to API only from my IP
data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

# create EKS cluster
/* 
specifications:
- version: 1.31
- place EKS cluster in private subnets
- allow access to EKS API from public only from my IP
- managed ADDONS
 */
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-cluster-role.arn
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids = var.private_subnet_ids
    public_access_cidrs = ["${chomp(data.http.my_ip.response_body)}/32"]
  }
  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }
  bootstrap_self_managed_addons = true
  tags                          = var.tags
  version                       = var.eks_version
  upgrade_policy {
    support_type = "STANDARD"
  }
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}


##### WORKER NODES #####

# create role & assign policies
resource "aws_iam_role" "eks-ng-role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-ng-WorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-ng-role.name
}

resource "aws_iam_role_policy_attachment" "eks-ng-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-ng-role.name
}

resource "aws_iam_role_policy_attachment" "eks-ng-ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-ng-role.name
}

# create worker node group
/* 
specifications:
- 4 worker nodes
- t3.medium (just host simple web applicatio
 */
resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = var.cluster_name
  node_role_arn   = aws_iam_role.eks-ng-role.arn
  node_group_name = var.worker_node_group_name
  subnet_ids = var.private_subnet_ids
  instance_types = var.instance_type
  ami_type       = var.ami_type

  scaling_config {
    desired_size = 4
    max_size     = 4
    min_size     = 4
  }
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-ng-WorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-ng-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-ng-ContainerRegistryReadOnly,
  ]
}