# EJ-AWS-03: Crear un Bucket S3 con Versionado y Cifrado

## 🎯 Objetivo
Configurar un bucket de Amazon S3 utilizando Terraform, aplicando buenas prácticas de seguridad como el versionado, cifrado en reposo y bloqueo de acceso público. Además, se implementará una política de ciclo de vida para optimizar costos.

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

### Paso 1: Configurar variables personales
Para evitar conflictos en la cuenta compartida (ya que los nombres de S3 son únicos globales), cada alumno deberá usar su nombre y un ID.


### Paso 2: Ejecuta los comandos pasando tus datos como variables:
```bash
terraform init

# Reemplaza 'tu_nombre' y 'tu_id' (ej: aldo y 01)
terraform plan -var="student_name=tu_nombre" -var="student_id=tu_id"
terraform apply -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
```

### Paso 3: Verificar en AWS Console
- Ir a S3 en la consola de AWS.
- Localizar el bucket: utec-iac-lab-[tu_nombre]-[id].
- En la pestaña Propiedades, verificar que el "Versionado" y el "Cifrado predeterminado" estén habilitados.
- En la pestaña Administración, verificar la regla de ciclo de vida (Glacier).

### Paso 4: Ver Outputs
```bash
terraform output
```

### Paso 5: Destruir
```bash
terraform destroy -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
```

### Paso 6: Resultado esperado
```bash
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:
bucket_name       = "utec-iac-lab-jose-01"
bucket_region     = "us-east-1"
versioning_status = "Enabled"
```