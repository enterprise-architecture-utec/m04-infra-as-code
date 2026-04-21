variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-utec-lab01"
}

variable "storage_account_name" {
  description = "Nombre unico de la Storage Account (3-24 chars, solo minusculas y numeros)"
  type        = string
  default     = "suteclaboratorio01"
}

variable "container_name" {
  description = "Nombre del contenedor Blob"
  type        = string
  default     = "archivos-utec"
}
