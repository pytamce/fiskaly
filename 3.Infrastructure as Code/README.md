# 🏗️ Terraform Infrastructure — AWS EKS Cluster for Hello World App

This repository demonstrates a **Terraform-based infrastructure setup** for deploying a minimal Kubernetes environment suitable for the Hello World application.




---

## Architecture

For a detailed description of the EKS cluster that will be provision by using this terraform module please refer to [Architecture Overview](architecture.md).


---

## Files

```
README.md
modules/cluster/main.tf       # Main module for EKS k8s deployment
modules/cluster/variables.tf  # Variables for EKS k8s module
modules/cluster/outputs.tf    # Outputs from EKS k8s module
modules/network/main.tf       # Main module for whole network configuration
modules/network/variables.tf  # Variables for network configuration
modules/network/outputs.tf    # Outputs from network module
modules/security/main.tf      # Main module for security groups
modules/security/outputs.tf   # Outputs from security module
modules/security/variables.tf # Variables for security configuration
main.tf                       # Main ROOT module
backend.tf                    # Backend state file configuration
providers.tf                  # List of providers used in modules
variables.tf                  # Variables user for root module
```

---


### EKS Cluster

* **Cluster Version:** 1.31
* **Node Group:** 4 nodes, `t3.medium`
* **Subnets:** Private
* **Security:** Worker nodes SG, managed policies for control plane communication