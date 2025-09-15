# 🏗️ Terraform Infrastructure — AWS EKS Cluster for Hello World App

This repository demonstrates a **Terraform-based infrastructure setup** for deploying a minimal Kubernetes environment suitable for the Hello World application.
The Terraform configuration provisions:


---

## Task
A simple, startup infrastructure configuration as a code for a cloud of choice launching the following:
* VPC with subnets.
* A small, 4 nodes Kubernetes cluster that would be able to accommodate the kubernetes deployment prepared in previous exercise.
* Provide the proper network security configuration allowing only necessary traffic to our service.

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