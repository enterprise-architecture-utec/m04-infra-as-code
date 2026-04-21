variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-utec-lab01"
}

variable "vm_name" {
  description = "Nombre de la Virtual Machine"
  type        = string
  default     = "vm-utec-lab04"
}

variable "vm_size" {
  description = "Tamano de la VM (SKU)"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Usuario administrador de la VM"
  type        = string
  default     = "adminutec"
}

variable "admin_password" {
  description = "Contrasena del administrador (usar SSH key en produccion)"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}
