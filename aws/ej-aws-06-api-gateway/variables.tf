variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "api_name" {
  description = "Nombre del API Gateway"
  type        = string
  default     = "api-utec-lab06"
}

variable "lambda_function_name" {
  description = "Nombre de la funcion Lambda a integrar (del ejercicio AWS-04)"
  type        = string
  default     = "fn-utec-lab04"
}
