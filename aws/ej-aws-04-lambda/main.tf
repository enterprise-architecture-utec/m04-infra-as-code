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

# Empaquetar el codigo Python automaticamente
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/function-${var.student_name}.zip"
}

# IAM Role para Lambda (Nombre único por alumno)
resource "aws_iam_role" "lambda_role" {
  name = "role-utec-lambda-${var.student_name}-${var.student_id}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Curso  = "Arquitectura Multinube"
    Alumno = var.student_name
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# CloudWatch Log Group único
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/fn-utec-${var.student_name}-${var.student_id}"
  retention_in_days = 7
}

# Funcion Lambda única
resource "aws_lambda_function" "lambda_utec" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "fn-utec-${var.student_name}-${var.student_id}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout          = 30
  memory_size      = 128

  environment {
    variables = {
      ENTORNO = "laboratorio"
      CURSO   = "Arquitectura Multinube"
      ALUMNO  = var.student_name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_cloudwatch_log_group.lambda_logs
  ]

  tags = {
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
    Alumno = var.student_name
  }
}