variable "resource_group_name" {
  description = "Nombre del Resource Group en Azure"
  type        = string
  default     = "rg-utec-lab01"
}

variable "location" {
  description = "Region de Azure donde se creara el Resource Group"
  type        = string
  default     = "East US"
}
