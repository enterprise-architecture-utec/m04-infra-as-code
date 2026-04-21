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

### Paso 1: Empaquetar el código Python
```bash
# El archivo lambda_function.py ya está incluido en esta carpeta
zip function.zip lambda_function.py
```

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Invocar la función manualmente
```bash
FUNCTION=$(terraform output -raw function_name)

aws lambda invoke \
  --function-name $FUNCTION \
  --payload '{"nombre": "UTEC"}' \
  --cli-binary-format raw-in-base64-out \
  response.json

cat response.json
```

### Paso 4: Ver los logs en CloudWatch
```bash
aws logs tail /aws/lambda/$FUNCTION --follow
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
function_arn  = "arn:aws:lambda:us-east-1:123456789:function:fn-utec-lab04"
function_name = "fn-utec-lab04"
role_arn      = "arn:aws:iam::123456789:role/role-utec-lambda"
```

Respuesta de la invocación:
```json
{"statusCode": 200, "body": "Hola UTEC desde Lambda! Entorno: laboratorio"}
```

## 📝 Notas
- Lambda tiene 1 millón de invocaciones gratuitas por mes en el Free Tier.
- `source_code_hash` asegura que Terraform detecte cambios en el ZIP y redeploy automáticamente.
- En producción, usa `aws_cloudwatch_log_group` para configurar retención de logs.
