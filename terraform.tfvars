# ============================================================
# envs/dev/terraform.tfvars
# ============================================================
# To enable a service: flip its _enabled flag to true
# That's the ONLY change needed to add a service.
# ============================================================

project_name = "myapp"
environment  = "dev"
aws_region   = "us-east-1"
owner        = "platform-team"

# Networking
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Security
allowed_ssh_cidrs = ["0.0.0.0/0"]  # Restrict in prod!
app_port          = 8080

# ── EC2 ──────────────────────────────────────────────────
ec2_enabled          = true        # ← flip to true to create EC2
ec2_instance_type    = "t3.micro"
ec2_ami_id           = "ami-0c02fb55956c7d316"
ec2_instance_count   = 1
ec2_key_name         = ""            # ← add your key pair name
ec2_enable_eip       = false
ec2_root_volume_size = 20
ec2_user_data        = ""

# ── RDS ──────────────────────────────────────────────────
rds_enabled             = false      # ← flip to true to create RDS
rds_engine              = "postgres"
rds_engine_version      = "15.3"
rds_instance_class      = "db.t3.micro"
rds_db_name             = "appdb"
rds_username            = "dbadmin"
rds_password            = "devpassword123!"  # use SSM in prod
rds_allocated_storage   = 20
rds_multi_az            = false
rds_skip_final_snapshot = true

# ── S3 ───────────────────────────────────────────────────
s3_enabled         = false           # ← flip to true to create S3
s3_bucket_name     = ""              # leave blank = auto-named
s3_versioning      = true
s3_force_destroy   = true
s3_lifecycle_days  = 30

# ── ECS ──────────────────────────────────────────────────
ecs_enabled         = false          # ← flip to true to create ECS
ecs_container_image = "nginx:latest"
ecs_desired_count   = 1
ecs_cpu             = 256
ecs_memory          = 512
