# ============================================================
# outputs.tf  — Root outputs
# Add new service outputs at the bottom when enabling modules
# ============================================================

# -------------------------------------------------------
# VPC
# -------------------------------------------------------
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

# -------------------------------------------------------
# Security Groups
# -------------------------------------------------------
output "bastion_sg_id" {
  value = module.security_groups.bastion_sg_id
}

output "app_sg_id" {
  value = module.security_groups.app_sg_id
}

output "db_sg_id" {
  value = module.security_groups.db_sg_id
}

# -------------------------------------------------------
# EC2  (available when ec2_enabled = true)
# -------------------------------------------------------
output "ec2_instance_ids" {
  value = var.ec2_enabled ? module.ec2[0].instance_ids : []
}

output "ec2_public_ips" {
  value = var.ec2_enabled ? module.ec2[0].public_ips : []
}

output "ec2_private_ips" {
  value = var.ec2_enabled ? module.ec2[0].private_ips : []
}

# -------------------------------------------------------
# RDS  (available when rds_enabled = true)
# -------------------------------------------------------
output "rds_endpoint" {
  value     = var.rds_enabled ? module.rds[0].endpoint : ""
  sensitive = true
}

output "rds_port" {
  value = var.rds_enabled ? module.rds[0].port : 0
}

# -------------------------------------------------------
# S3  (available when s3_enabled = true)
# -------------------------------------------------------
output "s3_bucket_name" {
  value = var.s3_enabled ? module.s3[0].bucket_name : ""
}

output "s3_bucket_arn" {
  value = var.s3_enabled ? module.s3[0].bucket_arn : ""
}

# -------------------------------------------------------
# ECS  (available when ecs_enabled = true)
# -------------------------------------------------------
output "ecs_cluster_name" {
  value = var.ecs_enabled ? module.ecs[0].cluster_name : ""
}

output "ecs_service_name" {
  value = var.ecs_enabled ? module.ecs[0].service_name : ""
}
