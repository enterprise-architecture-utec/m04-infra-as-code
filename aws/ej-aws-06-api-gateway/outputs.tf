output "api_id" {
  description = "ID del API Gateway"
  value       = aws_apigatewayv2_api.api_utec.id
}

output "api_endpoint" {
  description = "URL del endpoint del API"
  value       = "${aws_apigatewayv2_stage.stage_lab.invoke_url}/hola"
}

output "api_base_url" {
  description = "URL base del Stage"
  value       = aws_apigatewayv2_stage.stage_lab.invoke_url
}

output "execution_arn" {
  description = "ARN de ejecucion del API Gateway"
  value       = aws_apigatewayv2_api.api_utec.execution_arn
}
