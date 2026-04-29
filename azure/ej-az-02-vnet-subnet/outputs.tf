output "vnet_name" {
  value = azurerm_virtual_network.vnet_utec.name
}

output "vnet_cidr" {
  value = azurerm_virtual_network.vnet_utec.address_space[0]
}

output "subnet_id" {
  value = azurerm_subnet.subnet_privada.id
}