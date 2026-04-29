output "vpc_id" {
  value = aws_vpc.vpc_utec.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc_utec.cidr_block
}

output "student_namespace" {
  value = var.student_name
}