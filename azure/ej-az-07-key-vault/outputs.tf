output "key_vault_name" {
  description = "Nombre del Key Vault creado"
  value       = azurerm_key_vault.kv_utec.name
}

output "key_vault_uri" {
  description = "URI del Key Vault"
  value       = azurerm_key_vault.kv_utec.vault_uri
}

output "key_vault_id" {
  description = "ID del Key Vault"
  value       = azurerm_key_vault.kv_utec.id
}
