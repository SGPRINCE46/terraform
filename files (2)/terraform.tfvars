# =============================================================================
# terraform.tfvars  —  override defaults here
# =============================================================================

aws_region = "us-east-1"
project    = "nginx-demo"

common_tags = {
  Project     = "nginx-demo"
  Environment = "dev"
  ManagedBy   = "terraform"
}

# Networking
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

# EC2 / ASG
instance_type = "t3.micro"
asg_desired   = 2
asg_min       = 1
asg_max       = 4
