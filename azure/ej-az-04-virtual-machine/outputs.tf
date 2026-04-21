output "vm_name" {
  description = "Nombre de la VM creada"
  value       = azurerm_linux_virtual_machine.vm_utec.name
}

output "vm_public_ip" {
  description = "IP publica de la VM"
  value       = azurerm_public_ip.pip_vm.ip_address
}

output "vm_private_ip" {
  description = "IP privada de la VM dentro de la VNet"
  value       = azurerm_network_interface.nic_vm.private_ip_address
}

output "vm_size" {
  description = "Tamano de la VM"
  value       = azurerm_linux_virtual_machine.vm_utec.size
}
