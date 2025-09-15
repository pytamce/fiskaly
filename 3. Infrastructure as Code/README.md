# Terraform Infrastructure — AWS EKS Cluster for Hello World App

This repository demonstrates a **Terraform-based infrastructure setup** for deploying a minimal Kubernetes environment suitable for the Hello World application.
The Terraform configuration provisions:

* **VPC** with public and private subnets
* **EKS cluster** with 4 worker nodes
* **Security groups** for proper network segmentation
* **Outputs** for easy access to the cluster

---

## Files

```
README.md
providers.tf    # Provider configuration
variables.tf    # Input variables for customization
outputs.tf      # Outputs like kubeconfig
network.tf      # VPC, subnets, route tables, IGW
security.tf     # Security groups for nodes and LB      
cluster.tf      # EKS cluster and node groups (roles/polic)
```

---


### EKS Cluster

* **Cluster Version:** 1.31
* **Node Group:** 4 nodes, `t3.medium`
* **Subnets:** Private
* **Security:** Worker nodes SG, managed policies for control plane communication