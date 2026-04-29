output "function_name" {
  value = aws_lambda_function.lambda_utec.function_name
}

output "function_arn" {
  value = aws_lambda_function.lambda_utec.arn
}

output "role_arn" {
  value = aws_iam_role.lambda_role.arn
}