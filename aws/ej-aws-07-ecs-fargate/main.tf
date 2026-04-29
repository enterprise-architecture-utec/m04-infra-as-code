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

locals {
  base_name    = "${var.student_name}-${var.student_id}"
  cluster_name = var.cluster_name != "" ? var.cluster_name : "${local.base_name}-cluster-utec-lab07"
  service_name = "${local.base_name}-svc-utec-nginx"
  task_family  = "${local.base_name}-task-utec-nginx"
}

resource "aws_vpc" "vpc_utec" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "vpc-${local.base_name}-utec"
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
    Alumno = var.student_name
    AlumnoId = var.student_id
  }
}

resource "aws_subnet" "subnet_publica" {
  vpc_id                  = aws_vpc.vpc_utec.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-publica-${local.base_name}"
    Tipo = "Public"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_utec.id

  tags = {
    Name = "igw-${local.base_name}-utec"
  }
}

resource "aws_route_table" "rt_publica" {
  vpc_id = aws_vpc.vpc_utec.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-publica-${local.base_name}"
  }
}

resource "aws_route_table_association" "rta_publica" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.rt_publica.id
}

# IAM Role para la ejecucion de tareas ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "role-${local.base_name}-ecs-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# CloudWatch Log Group para los contenedores
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${local.base_name}-utec-nginx"
  retention_in_days = 7
}

# Security Group para las tareas ECS
resource "aws_security_group" "sg_ecs" {
  name        = "sg-${local.base_name}-ecs-lab07"
  description = "Security group para tareas ECS Fargate"
  vpc_id      = aws_vpc.vpc_utec.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg-${local.base_name}-ecs-lab07"
    Curso = "Arquitectura Multinube"
  }
}

# Cluster ECS
resource "aws_ecs_cluster" "cluster_utec" {
  name = local.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Curso  = "Arquitectura Multinube"
    Modulo = "Modulo 4 - IaC"
  }
}

# Task Definition (plano del contenedor)
resource "aws_ecs_task_definition" "task_nginx" {
  family                   = local.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true

      portMappings = [{
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }]

      environment = [
        { name = "ENTORNO", value = "laboratorio" },
        { name = "CURSO", value = "Arquitectura Multinube" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "nginx"
        }
      }
    }
  ])

  tags = {
    Curso = "Arquitectura Multinube"
  }
}

# Servicio ECS (mantiene las tareas corriendo)
resource "aws_ecs_service" "svc_nginx" {
  name            = local.service_name
  cluster         = aws_ecs_cluster.cluster_utec.id
  task_definition = aws_ecs_task_definition.task_nginx.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet_publica.id]
    security_groups  = [aws_security_group.sg_ecs.id]
    assign_public_ip = true
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_policy]

  tags = {
    Curso = "Arquitectura Multinube"
  }
}
