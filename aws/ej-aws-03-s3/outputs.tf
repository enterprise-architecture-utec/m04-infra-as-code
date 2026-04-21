output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.bucket_utec.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.bucket_utec.arn
}

output "bucket_region" {
  description = "Region del bucket"
  value       = aws_s3_bucket.bucket_utec.region
}

output "versioning_status" {
  description = "Estado del versionado"
  value       = aws_s3_bucket_versioning.versioning.versioning_configuration[0].status
}
