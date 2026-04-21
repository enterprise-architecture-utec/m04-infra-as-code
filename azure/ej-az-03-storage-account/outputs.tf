output "storage_account_name" {
  description = "Nombre de la Storage Account"
  value       = azurerm_storage_account.sa_utec.name
}

output "blob_endpoint" {
  description = "Endpoint del servicio Blob"
  value       = azurerm_storage_account.sa_utec.primary_blob_endpoint
}

output "container_name" {
  description = "Nombre del contenedor Blob"
  value       = azurerm_storage_container.contenedor.name
}

output "primary_access_key" {
  description = "Clave de acceso primaria (sensible)"
  value       = azurerm_storage_account.sa_utec.primary_access_key
  sensitive   = true
}
