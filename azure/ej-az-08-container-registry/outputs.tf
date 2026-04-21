output "acr_name" {
  description = "Nombre del Container Registry"
  value       = azurerm_container_registry.acr_utec.name
}

output "acr_login_server" {
  description = "URL del Login Server del ACR"
  value       = azurerm_container_registry.acr_utec.login_server
}

output "acr_admin_username" {
  description = "Usuario admin del ACR"
  value       = azurerm_container_registry.acr_utec.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Password admin del ACR"
  value       = azurerm_container_registry.acr_utec.admin_password
  sensitive   = true
}
