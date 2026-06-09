# =============================================================================
# outputs.tf
# =============================================================================

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer — open this in your browser"
  value       = "http://${aws_lb.app.dns_name}"
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.app.arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the two public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the two private subnets"
  value       = aws_subnet.private[*].id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.app.id
}

output "nat_gateway_public_ip" {
  description = "Elastic IP of the single regional NAT Gateway"
  value       = aws_eip.nat.public_ip
}
