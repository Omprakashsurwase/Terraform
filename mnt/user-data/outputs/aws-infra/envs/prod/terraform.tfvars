# envs/prod/terraform.tfvars
project_name = "myapp"
environment  = "prod"
aws_region   = "us-east-1"
owner        = "platform-team"

vpc_cidr             = "10.2.0.0/16"
public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnet_cidrs = ["10.2.10.0/24", "10.2.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

allowed_ssh_cidrs = ["YOUR_OFFICE_IP/32"]  # ← restrict this!
app_port          = 8080

ec2_enabled          = true
ec2_instance_type    = "t3.medium"
ec2_ami_id           = "ami-0c02fb55956c7d316"
ec2_instance_count   = 2
ec2_key_name         = "prod-key-pair"
ec2_enable_eip       = true
ec2_root_volume_size = 50
ec2_user_data        = ""

rds_enabled             = true
rds_engine              = "postgres"
rds_engine_version      = "15.3"
rds_instance_class      = "db.t3.medium"
rds_db_name             = "appdb"
rds_username            = "dbadmin"
rds_password            = "FETCH_FROM_SECRETS_MANAGER"  # use SSM!
rds_allocated_storage   = 100
rds_multi_az            = true
rds_skip_final_snapshot = false

s3_enabled        = true
s3_bucket_name    = ""
s3_versioning     = true
s3_force_destroy  = false
s3_lifecycle_days = 90

ecs_enabled         = true
ecs_container_image = "your-ecr-repo:latest"
ecs_desired_count   = 2
ecs_cpu             = 1024
ecs_memory          = 2048
