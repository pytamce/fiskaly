# create SG for EKS worker nodes. Inbound to worker nodes on all TCP ports (0–65535) within the VPC CIDR range. Outbound allows connect to any IP on the internet on all protocols
resource "aws_security_group" "eks_nodes" {
  name        = "eks-nodes-sg"
  description = "Allow communication for EKS worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-nodes-sg"
  }
}

# create SG for ALB. Inbound allow from internet on port 80. Outbound allows to all ports to any IP on the internet
resource "aws_security_group" "lb" {
  name        = "hello-lb-sg"
  description = "Allow HTTP access from the internet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}
