# EJ-AWS-02: Crear una Instancia EC2

## 🎯 Objetivo
Lanzar una instancia EC2 con Amazon Linux 2023 en la VPC creada en el ejercicio anterior, con Security Group, Internet Gateway y acceso SSH.

## 📋 Conceptos Clave
- **EC2 (Elastic Compute Cloud):** Servicio de cómputo virtual de AWS.
- **AMI (Amazon Machine Image):** Imagen del sistema operativo que usa la instancia.
- **Security Group:** Firewall virtual que controla el tráfico entrante y saliente.
- **`data "aws_ami"`:** Data source que busca la AMI más reciente de forma dinámica.
- **`t2.micro`:** Tipo de instancia elegible para Free Tier (1 vCPU, 1 GB RAM).

## 📁 Archivos
```
ej-aws-02-ec2/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Pre-requisito
Asegúrate de tener creados los recursos del ejercicio AWS-01 (VPC y Subnet).

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Conectarse a la instancia
```bash
# Opción A: Session Manager (sin SSH key, requiere SSM Agent)
aws ssm start-session --target <instance_id>

# Opción B: EC2 Instance Connect (desde la consola AWS)
# Ir a EC2 → Instances → Seleccionar instancia → Connect → EC2 Instance Connect
```

### Paso 4: Verificar la instancia
```bash
terraform output ec2_public_ip
terraform output ec2_instance_id

# Desde la instancia (si tienes acceso)
uname -a
curl ifconfig.me  # Muestra la IP pública
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
ec2_instance_id = "i-0abc123..."
ec2_public_ip   = "54.X.X.X"
ec2_private_ip  = "10.0.1.X"
ami_id          = "ami-0abc123..."
```

## 📝 Notas
- `t2.micro` es elegible para la capa gratuita de AWS durante 12 meses (750 horas/mes).
- En producción usa llaves SSH (`aws_key_pair`) en lugar de EC2 Instance Connect.
- El `data "aws_ami"` siempre obtiene la imagen más reciente de Amazon Linux 2023.
