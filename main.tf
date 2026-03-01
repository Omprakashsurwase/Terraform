# ============================================================
# main.tf  — Root Orchestrator
# To add a new service: uncomment its module block below.
# Each module only needs the variables in its own folder.
# ============================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state — update bucket/table after bootstrapping
  backend "s3" {
    bucket         = "your-tf-state-bucket"          # ← change once
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner
    }
  }
}

# ============================================================
# MODULE: VPC  (always required — never comment out)
# ============================================================
module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# ============================================================
# MODULE: SECURITY GROUPS  (always required)
# ============================================================
module "security_groups" {
  source = "./modules/security-groups"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  vpc_cidr          = var.vpc_cidr
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
  app_port          = var.app_port
}

# ============================================================
# MODULE: EC2
# To add EC2: ensure ec2_enabled = true in your .tfvars
# ============================================================
module "ec2" {
  source = "./modules/ec2"
  count  = var.ec2_enabled ? 1 : 0

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.app_sg_id
  instance_type     = var.ec2_instance_type
  ami_id            = var.ec2_ami_id
  instance_count    = var.ec2_instance_count
  key_name          = var.ec2_key_name
  enable_eip        = var.ec2_enable_eip
  root_volume_size  = var.ec2_root_volume_size
  user_data         = var.ec2_user_data
}

# ============================================================
# MODULE: RDS
# To add RDS: ensure rds_enabled = true in your .tfvars
# ============================================================
module "rds" {
  source = "./modules/rds"
  count  = var.rds_enabled ? 1 : 0

  project_name       = var.project_name
  environment        = var.environment
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_id  = module.security_groups.db_sg_id
  db_engine          = var.rds_engine
  db_engine_version  = var.rds_engine_version
  db_instance_class  = var.rds_instance_class
  db_name            = var.rds_db_name
  db_username        = var.rds_username
  db_password        = var.rds_password
  allocated_storage  = var.rds_allocated_storage
  multi_az           = var.rds_multi_az
  skip_final_snapshot = var.rds_skip_final_snapshot
}

# ============================================================
# MODULE: S3
# To add S3: ensure s3_enabled = true in your .tfvars
# ============================================================
module "s3" {
  source = "./modules/s3"
  count  = var.s3_enabled ? 1 : 0

  project_name       = var.project_name
  environment        = var.environment
  bucket_name        = var.s3_bucket_name
  versioning_enabled = var.s3_versioning
  force_destroy      = var.s3_force_destroy
  lifecycle_days     = var.s3_lifecycle_days
}

# ============================================================
# MODULE: ECS
# To add ECS: ensure ecs_enabled = true in your .tfvars
# ============================================================
module "ecs" {
  source = "./modules/ecs"
  count  = var.ecs_enabled ? 1 : 0

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.app_sg_id
  container_image   = var.ecs_container_image
  container_port    = var.app_port
  desired_count     = var.ecs_desired_count
  cpu               = var.ecs_cpu
  memory            = var.ecs_memory
}
