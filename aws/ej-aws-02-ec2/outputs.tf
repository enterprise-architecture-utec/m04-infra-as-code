output "ec2_instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.ec2_utec.id
}

output "ec2_public_ip" {
  description = "IP publica de la instancia"
  value       = aws_instance.ec2_utec.public_ip
}

output "ec2_private_ip" {
  description = "IP privada de la instancia"
  value       = aws_instance.ec2_utec.private_ip
}

output "ami_id" {
  description = "ID de la AMI utilizada"
  value       = data.aws_ami.amazon_linux.id
}

output "web_url" {
  description = "URL para acceder al nginx instalado"
  value       = "http://${aws_instance.ec2_utec.public_ip}"
}
