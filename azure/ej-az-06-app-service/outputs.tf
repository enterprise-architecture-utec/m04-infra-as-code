output "webapp_name" {
  description = "Nombre de la Web App"
  value       = azurerm_linux_web_app.webapp_utec.name
}

output "webapp_url" {
  description = "URL publica de la Web App"
  value       = "https://${azurerm_linux_web_app.webapp_utec.default_hostname}"
}

output "app_service_plan_id" {
  description = "ID del App Service Plan"
  value       = azurerm_service_plan.asp_utec.id
}
