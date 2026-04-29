output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.vpc_utec.id
}

output "subnet_id" {
  description = "ID de la subnet pública creada"
  value       = aws_subnet.subnet_publica.id
}

output "cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.cluster_utec.name
}

output "cluster_arn" {
  description = "ARN del cluster ECS"
  value       = aws_ecs_cluster.cluster_utec.arn
}

output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.svc_nginx.name
}

output "task_definition" {
  description = "Task definition con revision"
  value       = aws_ecs_task_definition.task_nginx.arn
}

output "log_group" {
  description = "CloudWatch Log Group de los contenedores"
  value       = aws_cloudwatch_log_group.ecs_logs.name
}
