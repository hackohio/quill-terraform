# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnets
output "intra_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.intra_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# Server IP
output "Quill_Server_IP" {
  description = "The IP Address of the quill server"
  value       = aws_instance.quillTerraformServer.public_ip
}

output "EIP" {
  description = "The Elastic IP Address of the quill server"
  value       = aws_eip.website_ip.public_ip
}
