# 🌐 Ejercicios Guiados — Terraform Multinube

**Curso:** Arquitectura de Soluciones Multinube  
**Módulo 4:** Aprovisionamiento con IaC y Automatización  
**Docente:** Aldo Trucios — UTEC Posgrado

---

## 📁 Estructura del Repositorio

```
terraform-labs/
├── azure/
│   ├── ej-az-02-vnet-subnet/
│   ├── ej-az-03-storage-account/
├── aws/
│   ├── ej-aws-01-vpc/
│   ├── ej-aws-03-s3/
│   ├── ej-aws-04-lambda/
│   ├── ej-aws-07-ecs-fargate/
└── gcp/
    ├── ej-gcp-01-vpc/
    ├── ej-gcp-05-cloud-functions/
```

---

## ⚙️ Requisitos Previos

| Herramienta | Versión mínima | Instalación |
|-------------|---------------|-------------|
| Terraform | >= 1.5.0 | https://developer.hashicorp.com/terraform/install |
| Azure CLI | >= 2.50 | https://learn.microsoft.com/cli/azure/install-azure-cli |
| AWS CLI | >= 2.13 | https://aws.amazon.com/cli/ |
| gcloud CLI | >= 450.0 | https://cloud.google.com/sdk/docs/install |

---

##  Install Terraform
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform -version
```


## 🔐 Autenticación

### Azure
```bash
az login
az account set --subscription "<ID_DE_TU_SUSCRIPCION>"
```

### AWS
```bash
aws configure
# Ingresa: Access Key ID, Secret Access Key, Region (us-east-1), Output (json)
```

### GCP
```bash
gcloud auth application-default login
gcloud config set project <ID_DE_TU_PROYECTO>
```

---

## 🚀 Flujo de Trabajo Terraform (aplica a todos los ejercicios)

```bash
# 1. Inicializar el directorio de trabajo
terraform init

# 2. Validar la sintaxis del código
terraform validate

# 3. Planificar los cambios
terraform plan

# 4. Aplicar la infraestructura
terraform apply -auto-approve

# 5. Destruir la infraestructura (al terminar el laboratorio)
terraform destroy -auto-approve
```

---

## 📚 Índice de Ejercicios

### ☁️ Azure
| # | Ejercicio | Servicio | Tiempo estimado |
|---|-----------|----------|----------------|
| AZ-02 | [Crear VNet y Subnet](azure/ej-az-02-vnet-subnet/README.md) | Virtual Network | 15 min |
| AZ-03 | [Storage Account y Blob](azure/ej-az-03-storage-account/README.md) | Storage | 15 min |

### ☁️ AWS
| # | Ejercicio | Servicio | Tiempo estimado |
|---|-----------|----------|----------------|
| AWS-01 | [Crear VPC y Subnet](aws/ej-aws-01-vpc/README.md) | VPC | 15 min |
| AWS-03 | [S3 Bucket con Versionado](aws/ej-aws-03-s3/README.md) | S3 | 15 min |
| AWS-04 | [Función Lambda](aws/ej-aws-04-lambda/README.md) | Serverless | 20 min |
| AWS-07 | [ECS Fargate](aws/ej-aws-07-ecs-fargate/README.md) | Contenedores | 25 min |

### ☁️ GCP
| # | Ejercicio | Servicio | Tiempo estimado |
|---|-----------|----------|----------------|
| GCP-01 | [VPC y Subnet](gcp/ej-gcp-01-vpc/README.md) | VPC | 15 min |
| GCP-05 | [Cloud Functions](gcp/ej-gcp-05-cloud-functions/README.md) | Serverless | 20 min |

---

> 💡 **Consejo:** Siempre ejecuta `terraform destroy` al finalizar cada laboratorio para evitar costos innecesarios.
