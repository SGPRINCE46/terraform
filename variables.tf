# =============================================================================
# variables.tf
# =============================================================================

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Short project name used as a prefix for all resource names"
  type        = string
  default     = "nginx-demo"
}

variable "common_tags" {
  description = "Tags applied to every resource"
  type        = map(string)
  default = {
    Project     = "nginx-demo"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

# ---------------------------------------------------------------------------
# Networking
# ---------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the two public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Exactly two public subnet CIDRs must be provided."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the two private subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Exactly two private subnet CIDRs must be provided."
  }
}

# ---------------------------------------------------------------------------
# EC2 / ASG
# ---------------------------------------------------------------------------

variable "instance_type" {
  description = "EC2 instance type for the Auto Scaling Group"
  type        = string
  default     = "t3.micro"
}

variable "asg_desired" {
  description = "Desired number of EC2 instances in the ASG"
  type        = number
  default     = 2
}

variable "asg_min" {
  description = "Minimum number of EC2 instances in the ASG"
  type        = number
  default     = 1
}

variable "asg_max" {
  description = "Maximum number of EC2 instances in the ASG"
  type        = number
  default     = 4
}
