output "bucket_name" {
  description = "Nombre del bucket"
  value       = google_storage_bucket.bucket_utec.name
}

output "bucket_url" {
  description = "URL gs:// del bucket"
  value       = "gs://${google_storage_bucket.bucket_utec.name}"
}

output "bucket_self_link" {
  description = "Self-link del bucket"
  value       = google_storage_bucket.bucket_utec.self_link
}

output "bucket_location" {
  description = "Ubicacion del bucket"
  value       = google_storage_bucket.bucket_utec.location
}
