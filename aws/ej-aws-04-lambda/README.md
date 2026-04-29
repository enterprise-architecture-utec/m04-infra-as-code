# EJ-AWS-04: Crear una Función Lambda con IAM Role

## 🎯 Objetivo
Desplegar una función Lambda en Python con su Role IAM, configurar variables de entorno y ejecutarla de forma serverless.

## 📋 Conceptos Clave
- **Lambda:** Servicio serverless que ejecuta código en respuesta a eventos, sin gestionar servidores.
- **IAM Role:** Identidad con permisos específicos que asume la función Lambda en tiempo de ejecución.
- **`assume_role_policy`:** Política que define qué servicio puede asumir el rol (en este caso, `lambda.amazonaws.com`).
- **Deployment Package:** Archivo ZIP con el código fuente de la función.

## 📁 Archivos
```
ej-aws-04-lambda/
├── main.tf
├── variables.tf
├── outputs.tf
├── lambda_function.py   ← Código de la función
└── README.md
```

## 🚀 Pasos

### Paso 1: Aplicar
```bash
terraform init
terraform plan -var="student_name=tu_nombre" -var="student_id=tu_id"
terraform apply -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
```

### Paso 3: Invocar la función manualmente
```bash
# Obtener el nombre generado automáticamente
FUNCTION=$(terraform output -raw function_name)

aws lambda invoke \
  --function-name $FUNCTION \
  --region us-east-1 \
  --payload '{"nombre": "UTEC"}' \
  --cli-binary-format raw-in-base64-out \
  response.json

cat response.json
```

### Paso 4: Ver los logs en CloudWatch
```bash
aws logs tail /aws/lambda/$FUNCTION
```

### Paso 5: Destruir
```bash
terraform destroy -var="student_name=tu_nombre" -var="student_id=tu_id" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
function_name = "fn-utec-jose-04"
role_arn      = "arn:aws:iam::123456789:role/role-utec-lambda-jose-04"
```


## 📝 Notas
- Lambda tiene 1 millón de invocaciones gratuitas por mes en el Free Tier.
