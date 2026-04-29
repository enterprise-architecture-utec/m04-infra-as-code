output "bucket_name" {
  description = "Nombre del bucket S3 generado"
  value       = aws_s3_bucket.bucket_utec.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket_utec.arn
}

output "versioning_status" {
  value = aws_s3_bucket_versioning.versioning.versioning_configuration[0].status
}