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

# VPC Principal con CIDR dinámico: 10.[student_id].0.0/16
resource "aws_vpc" "vpc_utec" {
  cidr_block           = "${var.vpc_cidr_base}.${var.student_id}.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "vpc-utec-${var.student_name}"
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
    Alumno = var.student_name
  }
}

# Subnet Publica: 10.[student_id].1.0/24
resource "aws_subnet" "subnet_publica" {
  vpc_id                  = aws_vpc.vpc_utec.id
  cidr_block              = "${var.vpc_cidr_base}.${var.student_id}.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-publica-${var.student_name}"
    Type = "Public"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_utec.id

  tags = {
    Name = "igw-utec-${var.student_name}"
  }
}

# Route Table
resource "aws_route_table" "rt_publica" {
  vpc_id = aws_vpc.vpc_utec.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-publica-${var.student_name}"
  }
}

resource "aws_route_table_association" "rta_publica" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.rt_publica.id
}