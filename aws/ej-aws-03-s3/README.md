# EJ-AWS-03: Crear un Bucket S3 con Versionado y Cifrado

## 🎯 Objetivo
Crear un bucket S3 con buenas prácticas de seguridad: versionado habilitado, cifrado AES-256 en reposo y bloqueo de acceso público.

## 📋 Conceptos Clave
- **S3 (Simple Storage Service):** Almacenamiento de objetos altamente disponible y duradero.
- **Versioning:** Guarda múltiples versiones de cada objeto, permitiendo recuperación ante borrados accidentales.
- **SSE-S3 (AES-256):** Cifrado en reposo del lado del servidor gestionado por AWS.
- **Public Access Block:** Evita que el bucket o sus objetos sean expuestos accidentalmente a Internet.

## 📁 Archivos
```
ej-aws-03-s3/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Ajustar el nombre del bucket
El nombre debe ser **único globalmente** en AWS. Edita `variables.tf` y cambia `bucket_name`.

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Subir un archivo de prueba
```bash
BUCKET=$(terraform output -raw bucket_name)

# Subir un archivo
echo "Hola UTEC desde S3" > test.txt
aws s3 cp test.txt s3://$BUCKET/test.txt

# Listar objetos
aws s3 ls s3://$BUCKET/

# Subir segunda version del archivo
echo "Version 2 del archivo" > test.txt
aws s3 cp test.txt s3://$BUCKET/test.txt

# Ver versiones
aws s3api list-object-versions --bucket $BUCKET --prefix test.txt
```

### Paso 4: Destruir
```bash
# Vaciar el bucket primero (requerido antes de destroy)
aws s3 rm s3://$BUCKET --recursive
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
bucket_arn           = "arn:aws:s3:::utec-laboratorio-multinube-2024"
bucket_name          = "utec-laboratorio-multinube-2024"
bucket_region        = "us-east-1"
versioning_status    = "Enabled"
```

## 📝 Notas
- Los nombres de bucket S3 son globalmente únicos en toda AWS — agrega tu nombre o fecha.
- `force_destroy = true` en Terraform permite borrar el bucket aunque tenga objetos (útil en labs).
- En producción, usa `aws_s3_bucket_lifecycle_configuration` para gestionar costos automáticamente.
