output "resource_group_name" {
  description = "Nombre del Resource Group creado"
  value       = azurerm_resource_group.utec_rg.name
}

output "resource_group_location" {
  description = "Region donde se creo el Resource Group"
  value       = azurerm_resource_group.utec_rg.location
}

output "resource_group_id" {
  description = "ID completo del Resource Group"
  value       = azurerm_resource_group.utec_rg.id
}
