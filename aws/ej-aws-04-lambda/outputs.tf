output "function_name" {
  description = "Nombre de la funcion Lambda"
  value       = aws_lambda_function.lambda_utec.function_name
}

output "function_arn" {
  description = "ARN de la funcion Lambda"
  value       = aws_lambda_function.lambda_utec.arn
}

output "role_arn" {
  description = "ARN del IAM Role de Lambda"
  value       = aws_iam_role.lambda_role.arn
}

output "cloudwatch_log_group" {
  description = "Grupo de logs en CloudWatch"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}
