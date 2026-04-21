# EJ-GCP-07: Crear Pub/Sub Topic y Subscription

## 🎯 Objetivo
Implementar el servicio de mensajería asíncrona de GCP (Pub/Sub) creando un topic, una suscripción pull y una suscripción push, siguiendo el patrón de mensajería pub/sub.

## 📋 Conceptos Clave
- **Pub/Sub:** Servicio de mensajería asíncrona de GCP — equivalente a SNS+SQS de AWS combinados.
- **Topic:** Canal de publicación de mensajes. Los productores publican aquí.
- **Subscription Pull:** El consumidor llama a la API para obtener mensajes (pull model).
- **Subscription Push:** GCP envía mensajes automáticamente a un endpoint HTTP (push model).
- **Acknowledge (ACK):** Confirmación de procesamiento del mensaje — si no se hace, el mensaje se reenvía.
- **Dead Letter Topic:** Topic secundario que recibe mensajes que no se pudieron procesar.

## 📁 Archivos
```
ej-gcp-07-pubsub/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Habilitar la API
```bash
gcloud services enable pubsub.googleapis.com
```

### Paso 2: Aplicar
```bash
terraform init
terraform plan -var="project_id=<TU_PROJECT_ID>"
terraform apply -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

### Paso 3: Publicar mensajes
```bash
TOPIC=$(terraform output -raw topic_name)

# Publicar mensaje simple
gcloud pubsub topics publish $TOPIC \
  --message="Hola desde UTEC - Mensaje 1"

# Publicar con atributos
gcloud pubsub topics publish $TOPIC \
  --message="Mensaje con atributos" \
  --attribute="origen=laboratorio,prioridad=alta"

# Publicar múltiples mensajes
for i in {1..5}; do
  gcloud pubsub topics publish $TOPIC \
    --message="Mensaje numero $i del laboratorio UTEC"
done
```

### Paso 4: Consumir mensajes (Pull)
```bash
SUB=$(terraform output -raw pull_subscription_name)

# Recibir y hacer ACK en un solo comando
gcloud pubsub subscriptions pull $SUB \
  --auto-ack \
  --limit=10 \
  --format="table(message.data.decode(base64),message.attributes)"
```

### Paso 5: Ver métricas
```bash
# Ver mensajes sin procesar en la suscripcion
gcloud pubsub subscriptions describe $(terraform output -raw pull_subscription_name) \
  --format="value(messageRetentionDuration)"
```

### Paso 6: Destruir
```bash
terraform destroy -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
dead_letter_topic_name    = "topic-utec-lab07-dlq"
pull_subscription_name    = "sub-utec-lab07-pull"
topic_id                  = "projects/mi-proyecto/topics/topic-utec-lab07"
topic_name                = "topic-utec-lab07"
```

## 📝 Notas
- Pub/Sub garantiza entrega **al menos una vez** — el consumidor debe manejar mensajes duplicados.
- `ack_deadline_seconds = 30` es el tiempo máximo para hacer ACK antes de que el mensaje sea re-enviado.
- `retain_acked_messages = false` libera espacio eliminando mensajes ya confirmados.
- El Dead Letter Topic captura mensajes que fallaron 5 veces consecutivas.
