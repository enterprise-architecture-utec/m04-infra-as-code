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

# Segunda subnet en otra AZ (requerida por RDS Subnet Group)
resource "aws_subnet" "subnet_rds" {
  vpc_id            = data.aws_vpc.vpc_utec.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "subnet-rds-utec"
    Type = "Private"
  }
}

# DB Subnet Group (requiere al menos 2 subnets en distintas AZs)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group-utec"
  subnet_ids = [data.aws_subnet.subnet_publica.id, aws_subnet.subnet_rds.id]

  tags = {
    Name  = "rds-subnet-group-utec"
    Curso = "Arquitectura Multinube"
  }
}

# Security Group para RDS
resource "aws_security_group" "sg_rds" {
  name        = "sg-utec-rds-lab05"
  description = "Security group para RDS MySQL"
  vpc_id      = data.aws_vpc.vpc_utec.id

  ingress {
    description = "MySQL desde la VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.vpc_utec.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg-utec-rds-lab05"
    Curso = "Arquitectura Multinube"
  }
}

# Instancia RDS MySQL
resource "aws_db_instance" "rds_utec" {
  identifier             = var.db_identifier
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  storage_type           = "gp2"
  storage_encrypted      = true
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  deletion_protection    = false

  tags = {
    Name   = "rds-utec-lab05"
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}
