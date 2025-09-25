## EKS Cluster Architecture

This manifest describes the architecture for the Amazon EKS (Elastic Kubernetes Service) cluster deployed using this terraform module. The setup focuses on following aspects:
- **scalability**
- **high availability**
- **security & observability**


1. Network Architecture

- VPC
    - A dedicated Amazon VPC is created for the EKS cluster.
    - Supports DNS resolution and hostnames.


- Availability Zones (AZs)
    - Multiple AZs are selected dynamically to improve fault tolerance. 
    - By default, two AZs are chosen, but this is configurable (az_count). This ensures workloads can survive an AZ failure.


- Subnets
    - Public Subnets: One public subnet per AZ, with map_public_ip_on_launch = true to allow internet connectivity for NAT Gateways and public-facing resources.
    - Private Subnets: One private subnet per AZ for EKS worker nodes and application workloads to keep them isolated from direct internet exposure.


- Internet Gateway & NAT Gateways
    - An Internet Gateway provides internet access for public subnets.
    - One NAT Gateway per AZ ensures high availability for private subnet outbound internet access, removing single points of failure.


- Route Tables
    - Public route table: Routes external traffic to the Internet Gateway.
    - Private route tables: One per AZ, each routing through its NAT Gateway for isolated outbound internet access.




2. Security Architecture


- Security Group for EKS Worker Nodes (eks_nodes):
    - Allows inbound traffic on all TCP ports (0–65535) within the VPC CIDR range for inter-node communication.
    - Outbound traffic is allowed to the internet on all ports and protocols.


- Security Group for Application Load Balancer (lb):
    - Allows inbound HTTP traffic on port 80 from the internet (0.0.0.0/0).
    - Outbound traffic is unrestricted for backend communication.


This separation of security groups follows the principle of least privilege while enabling required access.




3. EKS Cluster Architecture


- Control Plane
    - Cluster version: 1.31
    - Private API Endpoint: Enabled for improved security.
    - Public API Endpoint: Enabled but restricted to the operator’s IP via CIDR filtering.
    - Subnets: The cluster control plane is deployed inside private subnets to enhance security.
    - IAM Role: Dedicated IAM role with AmazonEKSClusterPolicy attached.
    - Managed Add-ons


The cluster is configured to support self-managed and bootstrap add-ons to enhance flexibility and observability.


- Worker Nodes
    - Dedicated node group with a fixed size for predictability.
    - Desired capacity: 4 nodes.
    - Instance type: t3.medium (optimized for simple workloads; adjustable per workload needs).
    - AMI type: AL2023_ARM_64_STANDARD.


- High Availability:
    - Nodes are distributed across private subnets in multiple AZs, ensuring fault tolerance and workload resilience.


- IAM Role for Nodes:
    Dedicated IAM role with necessary policies:
    - AmazonEKSWorkerNodePolicy
    - AmazonEKS_CNI_Policy
    - AmazonEC2ContainerRegistryReadOnly




4. Scalability


- Cluster Autoscaling:
    - Worker nodes can be dynamically scaled by adjusting the node group configuration.


- Multi-AZ Deployment:
    - Distributes nodes and workloads across AZs for redundancy and balanced resource utilization.




5. High Availability


- Multi-AZ Deployment:
    - Both control plane and worker nodes are deployed across multiple AZs.


- Multiple NAT Gateways:
    - Each private subnet is associated with a NAT Gateway in its AZ, avoiding single points of failure.


-  Private Subnets for Workloads:
    - Protect workloads from direct internet exposure while allowing necessary connectivity.




6. Observability


- Observability can be provided through:
    - Kubernetes native tools (e.g., Prometheus, Grafana, CloudWatch integration).
    - Cloud-native monitoring for control plane and worker node metrics.
    - Logging enabled at multiple levels for troubleshooting and performance insights.




7. Security


- Key security features:
    - Private subnets for workloads to minimize internet exposure.
    - AMI roles scoped to least privilege.
    - Security Groups for strict traffic control.
    - API access restrictions to a trusted CIDR range (operator IP).
    - Separate route tables per AZ for traffic isolation.