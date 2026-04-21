# EJ-AZ-08: Crear un Azure Container Registry (ACR)

## 🎯 Objetivo
Crear un registro privado de contenedores Docker en Azure para almacenar, distribuir y versionar imágenes de aplicaciones de forma segura.

## 📋 Conceptos Clave
- **ACR (Azure Container Registry):** Registro privado compatible con Docker y OCI.
- **SKU Basic:** Tier básico con 10 GB de almacenamiento — suficiente para laboratorios.
- **Login Server:** URL del registry (ej: `acrUtecLab08.azurecr.io`).
- **Admin User:** Usuario administrativo para autenticación directa (no recomendado en producción).

## 📁 Archivos
```
ej-az-08-container-registry/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Aplicar
```bash
terraform init
terraform apply -auto-approve
```

### Paso 2: Autenticarse en el Registry
```bash
# Obtener credenciales del output
ACR_SERVER=$(terraform output -raw acr_login_server)
ACR_USER=$(terraform output -raw acr_admin_username)
ACR_PASS=$(terraform output -raw acr_admin_password)

# Login
docker login $ACR_SERVER -u $ACR_USER -p $ACR_PASS
```

### Paso 3: Subir una imagen de prueba
```bash
ACR_SERVER=$(terraform output -raw acr_login_server)

# Descargar imagen base
docker pull nginx:latest

# Etiquetar para el ACR
docker tag nginx:latest $ACR_SERVER/nginx:v1.0

# Subir al ACR
docker push $ACR_SERVER/nginx:v1.0
```

### Paso 4: Listar imágenes en el ACR
```bash
az acr repository list --name acrUtecLab08 --output table
az acr repository show-tags --name acrUtecLab08 --repository nginx --output table
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:
acr_login_server   = "acrUtecLab08.azurecr.io"
acr_name           = "acrUtecLab08"
acr_admin_username = <sensitive>
acr_admin_password = <sensitive>
```

## 📝 Notas
- El nombre del ACR debe ser único globalmente, solo alfanumérico, 5-50 caracteres.
- En producción usa **Managed Identity** y `role_assignment` en lugar de `admin_enabled`.
- SKU `Standard` y `Premium` ofrecen geo-replicación y Private Endpoints.
