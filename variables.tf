// ============================================
// variables.tf - All Input Variables
// ============================================

variable "aws_region" {
  description = "AWS region to deploy the EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "my-ec2-instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Size of root EBS volume in GB"
  type        = number
  default     = 20
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the instance (use your IP)"
  type        = string
  default     = "0.0.0.0/0"  # Restrict this to your IP in production!
}

variable "public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
# ============================================
# variables.tf - All Input Variables
# ============================================

variable "aws_region" {
  description = "AWS region to deploy the EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "my-ec2-instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Size of root EBS volume in GB"
  type        = number
  default     = 20
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the instance (use your IP)"
  type        = string
  default     = "0.0.0.0/0"  # Restrict this to your IP in production!
}

variable "public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}