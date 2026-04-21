# EJ-AWS-06: Crear un API Gateway HTTP + Lambda

## 🎯 Objetivo
Exponer la función Lambda del ejercicio anterior a través de un API Gateway HTTP para crear un endpoint REST público completamente serverless.

## 📋 Conceptos Clave
- **API Gateway v2 (HTTP API):** Servicio para crear, publicar y gestionar APIs REST o WebSocket.
- **Integration:** Conexión entre el API Gateway y el backend (Lambda en este caso).
- **Route:** Define el método HTTP y la ruta URL (`GET /hola`).
- **Stage:** Entorno de despliegue del API (prod, dev, laboratorio).
- **Lambda Permission:** Autoriza a API Gateway a invocar la función Lambda.

## 📁 Archivos
```
ej-aws-06-api-gateway/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Pre-requisito
Asegúrate de tener la función Lambda del ejercicio AWS-04 desplegada.

### Paso 2: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 3: Probar el endpoint
```bash
API_URL=$(terraform output -raw api_endpoint)

# Llamada GET
curl $API_URL

# Con parámetros en el body (POST)
curl -X POST $API_URL \
  -H "Content-Type: application/json" \
  -d '{"nombre": "Estudiante UTEC"}'
```

### Paso 4: Ver métricas en CloudWatch
```bash
# Ver logs del API Gateway
aws logs tail "API-Gateway-Execution-Logs_$(terraform output -raw api_id)/laboratorio" --follow
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:
api_endpoint = "https://abc123.execute-api.us-east-1.amazonaws.com/laboratorio/hola"
api_id       = "abc123xyz"
```

Respuesta del curl:
```json
{"statusCode": 200, "body": "Hola Estudiante UTEC desde Lambda!..."}
```

## 📝 Notas
- HTTP API es más barato y rápido que REST API v1 para casos de uso comunes.
- `auto_deploy = true` hace que los cambios se desplieguen automáticamente al Stage.
- El `source_arn` con `/*/*` permite todas las rutas y métodos del API.
