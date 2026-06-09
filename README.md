# AWS Nginx Infrastructure with Terraform

This Terraform project provisions a highly available AWS infrastructure for running Nginx inside Docker containers on EC2 instances managed by an Auto Scaling Group (ASG).

## Architecture

The infrastructure includes:

- VPC with DNS support enabled
- 2 Public Subnets across 2 Availability Zones
- 2 Private Subnets across 2 Availability Zones
- Internet Gateway
- Single NAT Gateway (cost-optimized)
- Application Load Balancer (ALB)
- Security Groups
- EC2 Launch Template
- Auto Scaling Group (ASG)
- IAM Role with AWS Systems Manager (SSM) access
- CloudWatch CPU-based Auto Scaling policies
- Dockerized Nginx deployment

## Architecture Diagram

```text
Internet
    │
    ▼
Application Load Balancer
    │
    ▼
Target Group
    │
    ▼
Auto Scaling Group
 ┌───────────────┐
 │ EC2 Instance  │
 │ Docker Nginx  │
 └───────────────┘
       ▲
       │
 Private Subnets
       │
       ▼
   NAT Gateway
       │
       ▼
 Internet Gateway
       │
       ▼
    Internet
```

## Features

### Networking

- Custom VPC (`10.0.0.0/16`)
- Two public subnets
- Two private subnets
- Internet Gateway for public access
- Single NAT Gateway for outbound internet access from private instances

### Security

#### ALB Security Group

Allows:

- HTTP (80) from anywhere
- HTTPS (443) from anywhere

#### EC2 Security Group

Allows:

- HTTP (80) only from ALB
- SSH (22) only within VPC CIDR

### Compute

- Amazon Linux 2023 AMI
- EC2 instances deployed in private subnets
- Docker installed automatically
- Nginx container started automatically

### Load Balancing

- Application Load Balancer
- Health checks enabled
- Traffic forwarding to EC2 instances

### Auto Scaling

Default configuration:

| Setting | Value |
|----------|--------|
| Desired Capacity | 2 |
| Minimum Capacity | 1 |
| Maximum Capacity | 4 |

Scaling Rules:

- Scale Out when CPU > 70%
- Scale In when CPU < 30%

### Management

- AWS Systems Manager (SSM) enabled
- No SSH key required
- Secure access through Session Manager

---

## Prerequisites

Install:

- Terraform >= 1.3.0
- AWS CLI
- AWS Account
- Configured AWS credentials

Verify installations:

```bash
terraform version
aws --version
```

Configure AWS credentials:

```bash
aws configure
```

---

## Project Structure

```text
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── README.md
```

---

## Deployment

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Review Execution Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

Approve when prompted:

```text
Enter a value: yes
```

---

## Destroy Infrastructure

To remove all resources:

```bash
terraform destroy
```

---

## Default Variables

| Variable | Default |
|-----------|-----------|
| aws_region | us-east-1 |
| project | nginx-demo |
| instance_type | t3.micro |
| asg_desired | 2 |
| asg_min | 1 |
| asg_max | 4 |

---

## Customization Example

Create a `terraform.tfvars` file:

```hcl
aws_region   = "us-east-1"
project      = "production-nginx"

instance_type = "t3.small"

asg_desired = 2
asg_min     = 2
asg_max     = 6
```

---

## Accessing the Application

After deployment:

1. Open AWS Console
2. Navigate to EC2 → Load Balancers
3. Copy the ALB DNS Name
4. Open in browser:

```text
http://<alb-dns-name>
```

You should see the default Nginx welcome page.

---

## Tags Applied

All resources are tagged with:

```text
Project     = nginx-demo
Environment = dev
ManagedBy   = terraform
```

---

## Cost Considerations

This deployment uses:

- 1 NAT Gateway
- Application Load Balancer
- EC2 Instances
- Elastic IP

AWS charges apply for these resources.

---

## Author

SG Prince

Terraform-based AWS Infrastructure for Dockerized Nginx with Auto Scaling and Load Balancing.
