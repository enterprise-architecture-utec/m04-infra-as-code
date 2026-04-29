variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nombre del cluster ECS. Si no se proporciona, se construye a partir de student_name"
  type        = string
  default     = ""
}

variable "desired_count" {
  description = "Numero de tareas deseadas en el servicio"
  type        = number
  default     = 1
}

variable "student_name" {
  description = "Nombre del estudiante (para evitar conflictos en recursos compartidos)"
  type        = string
}

variable "student_id" {
  description = "ID del estudiante (para evitar conflictos en recursos compartidos)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}
