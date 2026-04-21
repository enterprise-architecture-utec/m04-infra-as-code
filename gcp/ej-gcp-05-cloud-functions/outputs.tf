output "function_name" {
  description = "Nombre de la Cloud Function"
  value       = google_cloudfunctions2_function.fn_utec.name
}

output "function_url" {
  description = "URL de invocacion HTTP de la funcion"
  value       = google_cloudfunctions2_function.fn_utec.service_config[0].uri
}

output "function_region" {
  description = "Region donde se despliega la funcion"
  value       = google_cloudfunctions2_function.fn_utec.location
}

output "source_bucket" {
  description = "Bucket donde se almacena el codigo fuente"
  value       = google_storage_bucket.function_bucket.name
}
