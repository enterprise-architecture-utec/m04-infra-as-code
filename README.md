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
│   ├── ej-az-07-key-vault/
│   └── ej-az-08-container-registry/
├── aws/
│   ├── ej-aws-01-vpc/
│   ├── ej-aws-03-s3/
│   ├── ej-aws-04-lambda/
│   ├── ej-aws-07-ecs-fargate/
│   └── ej-aws-08-sns-sqs/
└── gcp/
    ├── ej-gcp-01-vpc/
    ├── ej-gcp-03-cloud-storage/
    ├── ej-gcp-05-cloud-functions/
    └── ej-gcp-07-pubsub/
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
| AZ-01 | [Crear un Resource Group](azure/ej-az-01-resource-group/README.md) | Resource Group | 10 min |
| AZ-02 | [Crear VNet y Subnet](azure/ej-az-02-vnet-subnet/README.md) | Virtual Network | 15 min |
| AZ-03 | [Storage Account y Blob](azure/ej-az-03-storage-account/README.md) | Storage | 15 min |
| AZ-04 | [Máquina Virtual Linux](azure/ej-az-04-virtual-machine/README.md) | Compute | 20 min |
| AZ-05 | [Azure SQL Database](azure/ej-az-05-sql-database/README.md) | Database | 20 min |
| AZ-06 | [App Service Web App](azure/ej-az-06-app-service/README.md) | PaaS | 15 min |
| AZ-07 | [Key Vault y Secretos](azure/ej-az-07-key-vault/README.md) | Seguridad | 15 min |
| AZ-08 | [Container Registry](azure/ej-az-08-container-registry/README.md) | Contenedores | 15 min |

### ☁️ AWS
| # | Ejercicio | Servicio | Tiempo estimado |
|---|-----------|----------|----------------|
| AWS-01 | [Crear VPC y Subnet](aws/ej-aws-01-vpc/README.md) | VPC | 15 min |
| AWS-02 | [Instancia EC2](aws/ej-aws-02-ec2/README.md) | EC2 | 20 min |
| AWS-03 | [S3 Bucket con Versionado](aws/ej-aws-03-s3/README.md) | S3 | 15 min |
| AWS-04 | [Función Lambda](aws/ej-aws-04-lambda/README.md) | Serverless | 20 min |
| AWS-05 | [RDS MySQL](aws/ej-aws-05-rds/README.md) | Database | 20 min |
| AWS-06 | [API Gateway + Lambda](aws/ej-aws-06-api-gateway/README.md) | API | 25 min |
| AWS-07 | [ECS Fargate](aws/ej-aws-07-ecs-fargate/README.md) | Contenedores | 25 min |
| AWS-08 | [SNS + SQS](aws/ej-aws-08-sns-sqs/README.md) | Mensajería | 15 min |

### ☁️ GCP
| # | Ejercicio | Servicio | Tiempo estimado |
|---|-----------|----------|----------------|
| GCP-01 | [VPC y Subnet](gcp/ej-gcp-01-vpc/README.md) | VPC | 15 min |
| GCP-02 | [Compute Engine VM](gcp/ej-gcp-02-compute-engine/README.md) | Compute | 20 min |
| GCP-03 | [Cloud Storage Bucket](gcp/ej-gcp-03-cloud-storage/README.md) | Storage | 15 min |
| GCP-04 | [Cloud SQL PostgreSQL](gcp/ej-gcp-04-cloud-sql/README.md) | Database | 20 min |
| GCP-05 | [Cloud Functions](gcp/ej-gcp-05-cloud-functions/README.md) | Serverless | 20 min |
| GCP-06 | [GKE Cluster](gcp/ej-gcp-06-gke/README.md) | Kubernetes | 25 min |
| GCP-07 | [Pub/Sub](gcp/ej-gcp-07-pubsub/README.md) | Mensajería | 15 min |

---

> 💡 **Consejo:** Siempre ejecuta `terraform destroy` al finalizar cada laboratorio para evitar costos innecesarios.
