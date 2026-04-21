variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "Nombre de la VPC existente (del ejercicio GCP-01)"
  type        = string
  default     = "vpc-utec-lab01"
}

variable "subnet_name" {
  description = "Nombre de la subnet existente"
  type        = string
  default     = "subnet-utec-lab01"
}

variable "vm_name" {
  description = "Nombre de la instancia de Compute Engine"
  type        = string
  default     = "vm-utec-lab02"
}

variable "machine_type" {
  description = "Tipo de maquina (e2-micro es Free Tier)"
  type        = string
  default     = "e2-micro"
}
