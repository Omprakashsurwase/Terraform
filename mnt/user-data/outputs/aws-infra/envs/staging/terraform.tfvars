# envs/staging/terraform.tfvars
project_name = "myapp"
environment  = "staging"
aws_region   = "us-east-1"
owner        = "platform-team"

vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

allowed_ssh_cidrs = ["10.0.0.0/8"]
app_port          = 8080

ec2_enabled          = true
ec2_instance_type    = "t3.small"
ec2_ami_id           = "ami-0c02fb55956c7d316"
ec2_instance_count   = 1
ec2_key_name         = ""
ec2_enable_eip       = false
ec2_root_volume_size = 30
ec2_user_data        = ""

rds_enabled             = true
rds_engine              = "postgres"
rds_engine_version      = "15.3"
rds_instance_class      = "db.t3.small"
rds_db_name             = "appdb"
rds_username            = "dbadmin"
rds_password            = "stagingpassword123!"
rds_allocated_storage   = 50
rds_multi_az            = false
rds_skip_final_snapshot = true

s3_enabled        = true
s3_bucket_name    = ""
s3_versioning     = true
s3_force_destroy  = false
s3_lifecycle_days = 60

ecs_enabled         = false
ecs_container_image = "nginx:latest"
ecs_desired_count   = 1
ecs_cpu             = 512
ecs_memory          = 1024
