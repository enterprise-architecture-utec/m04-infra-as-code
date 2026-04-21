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
Necesitas la VPC y Subnet del ejercicio AWS-01.

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
# ⏱️ ECS tarda ~2 minutos en lanzar las tareas
```

### Paso 3: Verificar el servicio en AWS Console
1. Ir a **ECS** → **Clusters** → `cluster-utec-lab07`
2. Seleccionar el servicio `svc-utec-nginx`
3. En la pestaña **Tasks**, verificar que la tarea está en estado `RUNNING`
4. Copiar la IP pública de la tarea y abrirla en el navegador

### Paso 4: Ver logs del contenedor
```bash
aws logs tail /ecs/utec-nginx --follow
```

### Paso 5: Escalar el servicio
```bash
# Escalar a 3 replicas
aws ecs update-service \
  --cluster cluster-utec-lab07 \
  --service svc-utec-nginx \
  --desired-count 3
```

### Paso 6: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:
cluster_arn      = "arn:aws:ecs:us-east-1:123456789:cluster/cluster-utec-lab07"
cluster_name     = "cluster-utec-lab07"
service_name     = "svc-utec-nginx"
task_definition  = "task-utec-nginx:1"
```

## 📝 Notas
- Fargate cobra por CPU y memoria reservada por segundo — solo pagas lo que usas.
- `256` CPU units = 0.25 vCPU; `512` MB = 0.5 GB RAM (la combinación más barata disponible).
- Para producción, usa un Application Load Balancer (ALB) en lugar de IP pública directa.
