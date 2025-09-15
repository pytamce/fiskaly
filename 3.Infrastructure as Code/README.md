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
modules/cluster/main.tf       # Main module for EKS k8s deployment
modules/cluster/variables.tf  # Variables for EKS k8s module
modules/cluster/outputs.tf    # Outputs from EKS k8s module
modules/network/main.tf       # Main module for whole network configuration
modules/network/variables.tf  # Variables for network configuration
modules/security/main.tf      # Main module for security groups
main.tf                       # Main ROOT module
```

---


### EKS Cluster

* **Cluster Version:** 1.31
* **Node Group:** 4 nodes, `t3.medium`
* **Subnets:** Private
* **Security:** Worker nodes SG, managed policies for control plane communication