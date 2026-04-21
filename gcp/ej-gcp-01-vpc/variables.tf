variable "project_id" {
  description = "ID del proyecto GCP (ej: mi-proyecto-123456)"
  type        = string
}

variable "region" {
  description = "Region de GCP"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "vpc-utec-lab01"
}

variable "subnet_name" {
  description = "Nombre de la subnet"
  type        = string
  default     = "subnet-utec-lab01"
}

variable "subnet_cidr" {
  description = "Bloque CIDR de la subnet"
  type        = string
  default     = "10.0.1.0/24"
}
