terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
  # state is stored locally by default for this minimal EC2 only setup
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# simple vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = { Name = "${var.project_name}-${var.environment}-vpc" }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

resource "aws_security_group" "instance_sg" {
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami = var.ec2_ami_id != "" ? var.ec2_ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = element(aws_subnet.public.*.id, 0)
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = var.ec2_key_name != "" ? var.ec2_key_name : null
  count                  = var.ec2_instance_count

  root_block_device {
    volume_size = var.ec2_root_volume_size
  }

  tags = { Name = "${var.project_name}-${var.environment}-ec2" }
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
