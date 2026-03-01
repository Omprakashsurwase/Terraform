# modules/rds/main.tf

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = { Name = "${var.project_name}-${var.environment}-db-subnet-group" }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project_name}-${var.environment}-db"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  allocated_storage       = var.allocated_storage
  storage_encrypted       = true
  storage_type            = "gp3"
  multi_az                = var.multi_az
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.security_group_id]
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = !var.skip_final_snapshot
  backup_retention_period = var.skip_final_snapshot ? 0 : 7
  tags                    = { Name = "${var.project_name}-${var.environment}-db" }
}
