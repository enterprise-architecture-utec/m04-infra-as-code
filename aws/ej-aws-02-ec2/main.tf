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

# Referencia a recursos del ejercicio AWS-01
data "aws_vpc" "vpc_utec" {
  filter {
    name   = "tag:Name"
    values = ["vpc-utec-lab01"]
  }
}

data "aws_subnet" "subnet_publica" {
  filter {
    name   = "tag:Name"
    values = ["subnet-publica-utec"]
  }
}

# AMI mas reciente de Amazon Linux 2023
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group para la EC2
resource "aws_security_group" "sg_ec2" {
  name        = "sg-utec-ec2-lab02"
  description = "Security group para EC2 - UTEC Lab"
  vpc_id      = data.aws_vpc.vpc_utec.id

  # Permitir SSH entrante
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir HTTP entrante
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir todo el trafico saliente
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg-utec-ec2-lab02"
    Curso = "Arquitectura Multinube"
  }
}

# Instancia EC2
resource "aws_instance" "ec2_utec" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.subnet_publica.id
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]

  # Script de inicio: instala nginx automaticamente
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Hola desde UTEC - EC2 Lab02</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name   = "ec2-utec-lab02"
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}
