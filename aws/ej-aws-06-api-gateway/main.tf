terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# Referenciar la funcion Lambda existente
data "aws_lambda_function" "lambda_utec" {
  function_name = var.lambda_function_name
}

# API Gateway HTTP API
resource "aws_apigatewayv2_api" "api_utec" {
  name          = var.api_name
  protocol_type = "HTTP"
  description   = "API REST para laboratorio UTEC - Arquitectura Multinube"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization"]
    max_age       = 300
  }

  tags = {
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}

# Integracion Lambda con el API Gateway
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.api_utec.id
  integration_type       = "AWS_PROXY"
  integration_uri        = data.aws_lambda_function.lambda_utec.invoke_arn
  payload_format_version = "2.0"
}

# Ruta GET /hola
resource "aws_apigatewayv2_route" "ruta_get" {
  api_id    = aws_apigatewayv2_api.api_utec.id
  route_key = "GET /hola"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Ruta POST /hola
resource "aws_apigatewayv2_route" "ruta_post" {
  api_id    = aws_apigatewayv2_api.api_utec.id
  route_key = "POST /hola"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Stage con auto-deploy
resource "aws_apigatewayv2_stage" "stage_lab" {
  api_id      = aws_apigatewayv2_api.api_utec.id
  name        = "laboratorio"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 100
    throttling_rate_limit  = 50
  }
}

# Permiso para que API Gateway invoque Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.lambda_utec.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_utec.execution_arn}/*/*"
}
