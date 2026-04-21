variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-utec-lab01"
}

variable "key_vault_name" {
  description = "Nombre unico del Key Vault (3-24 chars, alfanumerico y guiones)"
  type        = string
  default     = "kv-utec-lab07"
}

variable "db_password" {
  description = "Contrasena a almacenar en el Key Vault"
  type        = string
  default     = "MiP@ssw0rdSegura123"
  sensitive   = true
}
