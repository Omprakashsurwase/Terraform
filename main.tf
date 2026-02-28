# ============================================
# main.tf - EC2 Instance Creation Template
# ============================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ============================================
# PROVIDER CONFIGURATION
# ============================================

provider "aws" {
  region = var.aws_region
}

# ============================================
# DATA SOURCE - Fetch Latest Amazon Linux 2 AMI
# (Automatically picks latest AMI, no hardcoding)
# ============================================

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# ============================================
# SECURITY GROUP
# ============================================

resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"

  # Allow SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  # Allow HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.instance_name}-sg"
    Environment = var.environment
  }
}

# ============================================
# KEY PAIR (uses existing public key on runner)
# ============================================

resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.instance_name}-key"
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}

# ============================================
# EC2 INSTANCE
# ============================================

resource "aws_instance" "main" {
  # AMI - automatically fetched above
  ami           = data.aws_ami.amazon_linux.id

  # Instance type from variable
  instance_type = var.instance_type

  # Key pair for SSH access
  key_name      = aws_key_pair.ec2_key.key_name

  # Security group
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Root volume configuration
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }

  # User data script - runs on first boot automatically
  user_data = <<-EOF
    #!/bin/bash
    # Update system
    yum update -y

    # Install common tools
    yum install -y curl wget git htop

    # Set hostname
    hostnamectl set-hostname ${var.instance_name}

    # Log startup completion
    echo "EC2 instance ${var.instance_name} initialized successfully" >> /var/log/user-data.log
  EOF

  # Enable detailed monitoring
  monitoring = true

  # Tags
  tags = {
    Name        = var.instance_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}