variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "student_name" {
  description = "Nombre o iniciales del alumno (minúsculas)"
  type        = string
}

variable "student_id" {
  description = "ID único del alumno"
  type        = string
}