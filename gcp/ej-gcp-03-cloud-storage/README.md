# EJ-GCP-03: Crear un Cloud Storage Bucket

## 🎯 Objetivo
Crear un bucket en Cloud Storage con versionado, política de ciclo de vida y acceso uniforme a nivel de bucket, siguiendo las mejores prácticas de seguridad de GCP.

## 📋 Conceptos Clave
- **Cloud Storage:** Almacenamiento de objetos de GCP, equivalente a S3 en AWS.
- **Versionado:** Conserva versiones anteriores de los objetos ante modificaciones o eliminaciones.
- **Uniform Bucket-Level Access:** Desactiva las ACLs por objeto — el acceso se gestiona solo con IAM.
- **Lifecycle Rule:** Reglas automáticas para mover o eliminar objetos según condiciones (edad, versión, etc.).
- **Storage Class:** `STANDARD`, `NEARLINE` (acceso mensual), `COLDLINE` (acceso trimestral), `ARCHIVE`.

## 📁 Archivos
```
ej-gcp-03-cloud-storage/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Habilitar la API
```bash
gcloud services enable storage.googleapis.com
```

### Paso 2: Ajustar el nombre del bucket
El nombre debe ser único globalmente. Edita `variables.tf` y personaliza `bucket_name`.

### Paso 3: Aplicar
```bash
terraform init
terraform apply -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

### Paso 4: Subir y gestionar archivos
```bash
BUCKET=$(terraform output -raw bucket_name)

# Subir archivo
echo "Hola UTEC desde Cloud Storage" > archivo.txt
gsutil cp archivo.txt gs://$BUCKET/

# Listar objetos
gsutil ls gs://$BUCKET/

# Subir segunda version
echo "Version 2" > archivo.txt
gsutil cp archivo.txt gs://$BUCKET/

# Ver versiones
gsutil ls -a gs://$BUCKET/archivo.txt
```

### Paso 5: Destruir
```bash
# Vaciar el bucket primero
gsutil rm -r gs://$(terraform output -raw bucket_name)/**
terraform destroy -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:
bucket_name      = "bucket-utec-laboratorio-2024"
bucket_self_link = "https://www.googleapis.com/storage/v1/b/bucket-utec-laboratorio-2024"
bucket_url       = "gs://bucket-utec-laboratorio-2024"
```

## 📝 Notas
- `force_destroy = true` permite eliminar el bucket con objetos dentro desde Terraform (solo para labs).
- En producción, usa `Retention Policy` para evitar borrados accidentales.
- `NEARLINE` y `COLDLINE` son más baratos para datos de acceso infrecuente.
