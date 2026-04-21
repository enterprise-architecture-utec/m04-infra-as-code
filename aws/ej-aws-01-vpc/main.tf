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

# VPC Principal
resource "aws_vpc" "vpc_utec" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "vpc-utec-lab01"
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}

# Subnet Publica
resource "aws_subnet" "subnet_publica" {
  vpc_id                  = aws_vpc.vpc_utec.id
  cidr_block              = var.subnet_public_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-publica-utec"
    Type = "Public"
  }
}

# Internet Gateway para salida a Internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_utec.id

  tags = {
    Name = "igw-utec-lab01"
  }
}

# Route Table publica
resource "aws_route_table" "rt_publica" {
  vpc_id = aws_vpc.vpc_utec.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-publica-utec"
  }
}

# Asociar Route Table a la Subnet publica
resource "aws_route_table_association" "rta_publica" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.rt_publica.id
}
