# EJ-AWS-01: Configurar el Provider y Crear una VPC

## 🎯 Objetivo
Configurar el provider de AWS en Terraform y crear una VPC (Virtual Private Cloud) con una subred pública e Internet Gateway para permitir acceso a Internet.

## 📋 Conceptos Clave
- **VPC:** Red privada virtual aislada dentro de AWS — equivalente a una red on-premise.
- **Subnet:** Segmento de la VPC en una Availability Zone específica.
- **Internet Gateway (IGW):** Componente que permite la salida a Internet desde la VPC.
- **Route Table:** Tabla de enrutamiento que define hacia dónde va el tráfico de red.

## 🧭 Diagrama de Arquitectura
```text
      +-------------------------------------------+
      |                  VPC                      |
      |              10.x.0.0/16                  |
      |                                           |
      |   +-----------------------------------+   |
      |   |          Subnet Pública           |   |
      |   |          10.x.1.0/24              |   |
      |   |                                   |   |
      |   |  +-----------------------------+  |   |
      |   |  |   Recursos en AWS (EC2,      |  |   |
      |   |  |   ALB, etc.)                 |  |   |
      |   |  +-----------------------------+  |   |
      |   +-----------------------------------+   |
      +--------------------------|----------------+
                                 |
                                 v
                       +-------------------------+
                       |     Internet Gateway    |
                       |        (IGW)            |
                       +-------------------------+
``` 

## 📁 Archivos
```
ej-aws-01-vpc/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Configurar credenciales AWS
```bash
aws configure
# AWS Access Key ID: <tu_access_key>
# AWS Secret Access Key: <tu_secret_key>
# Default region name: us-east-1
# Default output format: json
```

### Paso 2: Aplicar
```bash
terraform init
# Ejemplo para el alumno Juan con ID 5
terraform plan -var="student_name=XXXXX" -var="student_id=XX"
terraform apply -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
```

### Paso 3: Verificar en AWS Console
1. Ir a **VPC** en la consola de AWS
2. Confirmar que `vpc-utec-lab01` existe con CIDR `10.0.0.0/16`
3. En **Subnets**, verificar `subnet-publica-utec` en `us-east-1a`
4. En **Internet Gateways**, verificar que el IGW está adjunto a la VPC

### Paso 4: Ver outputs
```bash
terraform output
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
igw_id          = "igw-0abc..."
subnet_id       = "subnet-0abc..."
vpc_id          = "vpc-0abc..."
vpc_cidr        = "10.0.0.0/16"
```

## 📝 Notas
- `enable_dns_hostnames = true` permite que las instancias EC2 tengan nombres DNS públicos.
- La Route Table asocia la subnet con el IGW para permitir tráfico de salida a Internet.
- Una VPC puede tener múltiples subnets en distintas Availability Zones para alta disponibilidad.
