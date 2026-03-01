# ============================================================
# envs/dev/terraform.tfvars
# ============================================================
# To enable a service: flip its _enabled flag to true
# That's the ONLY change needed to add a service.
# ============================================================

project_name = "myapp"
environment  = "dev"
aws_region   = "us-east-1"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["us-east-1a", "us-east-1b"]

allowed_ssh_cidrs = ["0.0.0.0/0"]

ec2_instance_type    = "t2.micro"
ec2_ami_id           = ""          # leave blank to use latest official Amazon Linux 2
ec2_instance_count   = 1
ec2_key_name         = "devops-key"
ec2_root_volume_size = 20

