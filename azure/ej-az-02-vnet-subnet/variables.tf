variable "resource_group_name" {
  description = "Nombre del Resource Group existente"
  type        = string
  default     = "rg-utec-lab01"
}

variable "vnet_name" {
  description = "Nombre de la Virtual Network"
  type        = string
  default     = "vnet-utec-lab02"
}

variable "vnet_cidr" {
  description = "Bloque CIDR de la VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Nombre de la subnet"
  type        = string
  default     = "snet-privada"
}

variable "subnet_cidr" {
  description = "Bloque CIDR de la subnet"
  type        = string
  default     = "10.0.1.0/24"
}
