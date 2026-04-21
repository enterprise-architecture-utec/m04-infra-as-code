# EJ-AWS-08: Crear SNS Topic y SQS Queue (Mensajería)

## 🎯 Objetivo
Implementar un patrón de mensajería pub/sub usando SNS (publicación de notificaciones) y SQS (cola de mensajes), conectados mediante una suscripción.

## 📋 Conceptos Clave
- **SNS (Simple Notification Service):** Servicio pub/sub que envía mensajes a múltiples suscriptores (SQS, Lambda, email, HTTP).
- **SQS (Simple Queue Service):** Cola de mensajes que desacopla productores y consumidores.
- **Suscripción SNS → SQS:** SNS reenvía cada mensaje publicado al topic directamente a la cola SQS.
- **Dead Letter Queue (DLQ):** Cola secundaria que recibe mensajes que no pudieron procesarse tras varios intentos.

## 📁 Archivos
```
ej-aws-08-sns-sqs/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Aplicar
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Paso 2: Publicar un mensaje en el Topic SNS
```bash
TOPIC_ARN=$(terraform output -raw sns_topic_arn)

aws sns publish \
  --topic-arn $TOPIC_ARN \
  --message "Hola desde UTEC - Mensaje de prueba" \
  --subject "Lab AWS-08"
```

### Paso 3: Consumir mensajes de la cola SQS
```bash
QUEUE_URL=$(terraform output -raw sqs_queue_url)

# Recibir mensajes (hasta 10 a la vez)
aws sqs receive-message \
  --queue-url $QUEUE_URL \
  --max-number-of-messages 10 \
  --wait-time-seconds 5

# Eliminar un mensaje (reemplaza el receipt-handle)
aws sqs delete-message \
  --queue-url $QUEUE_URL \
  --receipt-handle "<receipt-handle-del-mensaje>"
```

### Paso 4: Ver atributos de la cola
```bash
aws sqs get-queue-attributes \
  --queue-url $QUEUE_URL \
  --attribute-names All
```

### Paso 5: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
sns_topic_arn       = "arn:aws:sns:us-east-1:123456789:topic-utec-lab08"
sns_topic_name      = "topic-utec-lab08"
sqs_queue_arn       = "arn:aws:sqs:us-east-1:123456789:queue-utec-lab08"
sqs_queue_url       = "https://sqs.us-east-1.amazonaws.com/123456789/queue-utec-lab08"
sqs_dlq_url         = "https://sqs.us-east-1.amazonaws.com/123456789/queue-utec-lab08-dlq"
```

## 📝 Notas
- La política SQS es necesaria para que SNS tenga permisos de enviar mensajes a la cola.
- La DLQ (Dead Letter Queue) captura mensajes que fallaron tras 3 intentos de procesamiento.
- `visibility_timeout_seconds = 30` significa que un mensaje "invisible" durante 30s vuelve a estar disponible si no fue eliminado.
