terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# Bucket S3
resource "aws_s3_bucket" "bucket_utec" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name    = var.bucket_name
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
    Modulo  = "Modulo 4 - IaC"
  }
}

# Habilitar versionado
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket_utec.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cifrado en reposo con AES-256
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.bucket_utec.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Bloquear acceso publico (buena practica)
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.bucket_utec.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Politica de ciclo de vida: mover a Glacier despues de 90 dias
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket_utec.id

  rule {
    id     = "archive-rule"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
