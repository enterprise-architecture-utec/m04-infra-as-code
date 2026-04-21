variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-utec-lab01"
}

variable "acr_name" {
  description = "Nombre unico del ACR (solo alfanumerico, 5-50 chars)"
  type        = string
  default     = "acrUtecLab08"
}

variable "sku" {
  description = "SKU del ACR: Basic, Standard, Premium"
  type        = string
  default     = "Basic"
}
