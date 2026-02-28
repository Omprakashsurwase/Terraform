aws_region       = "us-east-1"
instance_name    = "my-server"
instance_type    = "t2.micro"
root_volume_size = 20
environment      = "dev"
ssh_allowed_cidr = "0.0.0.0/0"
public_key_path  = "~/.ssh/id_rsa.pub"