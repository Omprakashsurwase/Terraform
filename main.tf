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

