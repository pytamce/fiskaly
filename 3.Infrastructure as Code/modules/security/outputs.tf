output "eks_nodes_sg_id" {
  value = aws_security_group.eks_nodes.id
}

output "lb_sg_id" {
  value = aws_security_group.lb.id
}