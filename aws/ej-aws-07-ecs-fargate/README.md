# EJ-AWS-07: Crear un Cluster ECS con Fargate

## 🎯 Objetivo
Crear un clúster ECS con Fargate para ejecutar contenedores Docker sin gestionar servidores EC2 subyacentes. Fargate es el motor serverless de contenedores de AWS.

## 📋 Conceptos Clave
- **ECS (Elastic Container Service):** Servicio de orquestación de contenedores de AWS.
- **Fargate:** Motor serverless para ECS — no hay instancias EC2 que gestionar.
- **Task Definition:** Plano del contenedor (imagen, CPU, RAM, puertos, variables de entorno).
- **Service:** Mantiene el número deseado de tareas corriendo y las reinicia si fallan.
- **`awsvpc` network mode:** Cada tarea obtiene su propia Elastic Network Interface (ENI).

## 📁 Archivos
```
ej-aws-07-ecs-fargate/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Pre-requisitos
Este ejercicio es independiente y crea todos los recursos necesarios, incluyendo VPC, subnet y gateway de internet. No requiere recursos de otros ejercicios.

### Paso 1.5: Configurar variables
Para evitar conflictos con otros estudiantes en la misma cuenta de AWS, configura tus variables únicas:
```bash
export TF_VAR_student_name="tu_nombre"  # ej: "juan_perez"
export TF_VAR_student_id="tu_id"        # ej: "12345"
```
O pásalas directamente en los comandos de Terraform con `-var="student_name=tu_nombre" -var="student_id=tu_id"`.

El nombre del cluster se construye automáticamente como `{student_name}-{student_id}-cluster-utec-lab07` si no se proporciona `cluster_name`.

### Paso 2: Aplicar
```bash
terraform init
terraform plan -var="student_name=tu_nombre" -var="student_id=tu_id"
terraform apply -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
# ⏱️ ECS tarda ~2 minutos en lanzar las tareas
```

### Paso 3: Verificar el servicio en AWS Console
1. Ir a **ECS** → **Clusters** → `{tu_nombre}-cluster-utec-lab07`
2. Seleccionar el servicio `{tu_nombre}-svc-utec-nginx`
3. En la pestaña **Tasks**, verificar que la tarea está en estado `RUNNING`
4. Copiar la IP pública de la tarea y abrirla en el navegador

### Paso 4: Ver logs del contenedor
```bash
aws logs tail /ecs/{tu_nombre}-utec-nginx --follow
```

### Paso 5: Escalar el servicio
```bash
# Escalar a 3 replicas
aws ecs update-service \
  --cluster {tu_nombre}-cluster-utec-lab07 \
  --service {tu_nombre}-svc-utec-nginx \
  --desired-count 3
```

### Paso 6: Destruir
```bash
terraform destroy -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:
vpc_id           = "vpc-..."
subnet_id        = "subnet-..."
cluster_arn      = "arn:aws:ecs:us-east-1:123456789:cluster/{tu_nombre}-cluster-utec-lab07"
cluster_name     = "{tu_nombre}-cluster-utec-lab07"
service_name     = "{tu_nombre}-svc-utec-nginx"
task_definition  = "{tu_nombre}-task-utec-nginx:1"
```

## 📝 Notas
- Fargate cobra por CPU y memoria reservada por segundo — solo pagas lo que usas.
- `256` CPU units = 0.25 vCPU; `512` MB = 0.5 GB RAM (la combinación más barata disponible).
- Para producción, usa un Application Load Balancer (ALB) en lugar de IP pública directa.
