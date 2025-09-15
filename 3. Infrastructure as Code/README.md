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
terraform/
├─ providers.tf    # Provider configuration
├─ variables.tf    # Input variables for customization
├─ outputs.tf      # Outputs like kubeconfig
├─ network.tf      # VPC, subnets, route tables, IGW
├─ security.tf     # Security groups for nodes and LB
└─ cluster.tf      # EKS cluster and node groups
```

---

## Components Explanation

### 1. VPC

* **CIDR:** 10.0.0.0/16
* **Public Subnets:** 2 (for NAT gateways and LoadBalancer services)
* **Private Subnets:** 2 (for EKS worker nodes)
* **Routing:**

  * Public subnets → Internet Gateway
  * Private subnets → NAT Gateway → Internet (for outbound traffic)

### 2. Security Groups

* **EKS Worker Nodes:**

  * Allow inbound from within the VPC
  * Allow outbound internet access
* **LoadBalancer:**

  * Allow inbound TCP 80/443 from 0.0.0.0/0
  * Allow outbound to worker nodes

### 3. EKS Cluster

* **Cluster Version:** 1.31
* **Node Group:** 4 nodes, `t3.medium` (adjustable)
* **Subnets:** Private
* **Security:** Worker nodes SG, managed policies for control plane communication

### 4. Outputs

* **kubeconfig:** Allows `kubectl` to connect to the cluster
* Marked as `sensitive` to prevent accidental exposure of credentials

```hcl
output "kubeconfig" {
  value     = module.eks.kubeconfig
  sensitive = true
}
```

* Use with:

```bash
export KUBECONFIG=$(terraform output -raw kubeconfig)
kubectl get nodes
```

---

## Deployment Steps

1. Install Terraform and AWS CLI, configure credentials.
2. Navigate to the Terraform directory.
3. Initialize Terraform:

```bash
terraform init
```

4. Preview the infrastructure:

```bash
terraform plan
```

5. Apply the configuration:

```bash
terraform apply
```

6. Export kubeconfig to access EKS cluster:

```bash
export KUBECONFIG=$(terraform output -raw kubeconfig)
kubectl get nodes
```

7. Deploy your **Hello World app and Nginx manifests** from the Kubernetes exercise.

---

## Security Reasoning

* Only necessary traffic is allowed to the cluster:

  * Internet → LoadBalancer (port 80/443)
  * Internal cluster communication between Pods and nodes
* Worker nodes are in **private subnets**, no direct internet access except through NAT
* Security groups enforce **least privilege** network rules
* Terraform uses IAM-managed policies to securely communicate with AWS services

---

## Design Choices

* **Terraform:** declarative, reproducible, widely used for cloud IaC
* **EKS:** fully managed Kubernetes cluster for production-ready scalability
* **VPC with public/private subnets:** standard cloud network design
* **4-node cluster:** sufficient for small workloads, adjustable via node group settings
* **Outputs:** automated kubeconfig allows immediate kubectl access

---

This setup provides a **minimal yet production-aligned cloud infrastructure** for the Kubernetes Hello World application, ready for scaling, security, and automation demonstrations in an SRE interview context.
