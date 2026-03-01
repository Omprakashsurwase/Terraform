# ============================================================
# outputs.tf  — EC2‑only outputs
# ============================================================

output "ec2_instance_ids" {
  value = aws_instance.app.*.id
}

output "ec2_public_ips" {
  value = aws_instance.app.*.public_ip
}
