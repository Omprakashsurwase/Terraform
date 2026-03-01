# ============================================================
# variables.tf  — All input variables (root level)
# When adding a new service, append its variables at the
# bottom under a clearly labelled section. Nothing else
# needs to change in this file's existing content.
# ============================================================

variable "project_name" {
  description = "Project name — used as prefix in all resource names"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Must be: dev | staging | prod"
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "allowed_ssh_cidrs" {
  description = "IPs allowed to SSH. Restrict in prod!"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_ami_id" {
  description = "AMI ID to use for the instance. Leave blank to use the latest official Amazon Linux 2."
  type        = string
  default     = ""
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_key_name" {
  description = "EC2 Key Pair name for SSH access (existing key in your account)"
  type        = string
  default     = "my-key"
}

variable "ec2_root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "ec2_user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = ""
}

# -------------------------------------------------------
# RDS  (only used when rds_enabled = true)
# -------------------------------------------------------
variable "rds_enabled" {
  description = "Set to true to deploy RDS"
  type        = bool
  default     = false
}

variable "rds_engine" {
  type    = string
  default = "postgres"
}

variable "rds_engine_version" {
  type    = string
  default = "15.3"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_db_name" {
  type    = string
  default = "appdb"
}

variable "rds_username" {
  type    = string
  default = "dbadmin"
}

variable "rds_password" {
  description = "RDS password — use SSM Parameter Store or Secrets Manager in prod"
  type        = string
  sensitive   = true
  default     = "changeme123!"
}

variable "rds_allocated_storage" {
  type    = number
  default = 20
}

variable "rds_multi_az" {
  type    = bool
  default = false
}

variable "rds_skip_final_snapshot" {
  type    = bool
  default = true
}

# -------------------------------------------------------
# S3  (only used when s3_enabled = true)
# -------------------------------------------------------
variable "s3_enabled" {
  description = "Set to true to deploy S3 bucket"
  type        = bool
  default     = false
}

variable "s3_bucket_name" {
  description = "Globally unique bucket name"
  type        = string
  default     = ""
}

variable "s3_versioning" {
  type    = bool
  default = true
}

variable "s3_force_destroy" {
  type    = bool
  default = false
}

variable "s3_lifecycle_days" {
  description = "Move objects to Glacier after N days (0 = disabled)"
  type        = number
  default     = 90
}

# -------------------------------------------------------
# ECS  (only used when ecs_enabled = true)
# -------------------------------------------------------
variable "ecs_enabled" {
  description = "Set to true to deploy ECS Fargate cluster"
  type        = bool
  default     = false
}

variable "ecs_container_image" {
  type    = string
  default = "nginx:latest"
}

variable "ecs_desired_count" {
  type    = number
  default = 1
}

variable "ecs_cpu" {
  type    = number
  default = 256
}

variable "ecs_memory" {
  type    = number
  default = 512
}
