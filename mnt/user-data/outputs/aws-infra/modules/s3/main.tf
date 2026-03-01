# modules/s3/main.tf

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name != "" ? var.bucket_name : "${var.project_name}-${var.environment}-bucket"
  force_destroy = var.force_destroy
  tags          = { Name = "${var.project_name}-${var.environment}-bucket" }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.lifecycle_days > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    id     = "archive-to-glacier"
    status = "Enabled"
    transition {
      days          = var.lifecycle_days
      storage_class = "GLACIER"
    }
    filter { prefix = "" }
  }
}
