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
  description = <<EOF
Name of an existing EC2 key pair to attach to the instance.

If left blank, Terraform will automatically select the first key pair
returned by the AWS API in the current region. This ensures the plan
succeeds even when you don't know a key name in advance.
EOF
  type    = string
  default = ""
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

