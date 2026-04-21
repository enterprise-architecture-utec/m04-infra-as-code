output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.vpc_utec.id
}

output "vpc_cidr" {
  description = "CIDR de la VPC"
  value       = aws_vpc.vpc_utec.cidr_block
}

output "subnet_id" {
  description = "ID de la Subnet publica"
  value       = aws_subnet.subnet_publica.id
}

output "igw_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.igw.id
}
