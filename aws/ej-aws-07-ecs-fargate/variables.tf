variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
  default     = "cluster-utec-lab07"
}

variable "desired_count" {
  description = "Numero de tareas deseadas en el servicio"
  type        = number
  default     = 1
}
