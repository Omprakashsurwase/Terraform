# modules/ec2/main.tf

resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name != "" ? var.key_name : null
  user_data              = var.user_data != "" ? var.user_data : null

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  metadata_options {
    http_tokens = "required"  # IMDSv2 enforced
  }

  tags = { Name = "${var.project_name}-${var.environment}-ec2-${count.index + 1}" }
}

resource "aws_eip" "this" {
  count    = var.enable_eip ? var.instance_count : 0
  instance = aws_instance.this[count.index].id
  domain   = "vpc"
  tags     = { Name = "${var.project_name}-${var.environment}-eip-${count.index + 1}" }
}
