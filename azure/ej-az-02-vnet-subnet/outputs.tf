output "vnet_name" {
  description = "Nombre de la VNet creada"
  value       = azurerm_virtual_network.vnet_utec.name
}

output "vnet_id" {
  description = "ID de la VNet"
  value       = azurerm_virtual_network.vnet_utec.id
}

output "subnet_id" {
  description = "ID de la Subnet privada"
  value       = azurerm_subnet.subnet_privada.id
}

output "subnet_cidr" {
  description = "Rango CIDR de la Subnet"
  value       = azurerm_subnet.subnet_privada.address_prefixes[0]
}
