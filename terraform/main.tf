terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.30.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 Data Lake Bucket with KMS Encryption & Versioning
resource "aws_s3_bucket" "datalake" {
  bucket        = "${var.environment}-enterprise-datalake-${var.project_name}"
  force_destroy = false

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Databricks-Migration"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "datalake_enc" {
  bucket = aws_s3_bucket.datalake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "datalake_pab" {
  bucket                  = aws_s3_bucket.datalake.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Cross-Account IAM Role for Databricks Root Storage & Compute
resource "aws_iam_role" "databricks_storage_role" {
  name = "${var.environment}-databricks-storage-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::414351767826:root" # Databricks AWS Account ID
        }
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.databricks_account_id
          }
        }
      }
    ]
  })
}
