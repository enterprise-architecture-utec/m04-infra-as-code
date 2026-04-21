variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-utec-lab01"
}

variable "app_service_plan_name" {
  description = "Nombre del App Service Plan"
  type        = string
  default     = "asp-utec-lab06"
}

variable "webapp_name" {
  description = "Nombre unico de la Web App (globalmente unico)"
  type        = string
  default     = "webapp-utec-lab06"
}

variable "sku_name" {
  description = "SKU del App Service Plan (F1=Free, B1=Basic, S1=Standard)"
  type        = string
  default     = "F1"
}
