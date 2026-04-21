# EJ-AZ-06: Crear un Azure App Service (Web App)

## 🎯 Objetivo
Desplegar un App Service Plan y una Web App en Azure para alojar aplicaciones web en Python sin gestionar servidores. Es un servicio PaaS (Platform as a Service).

## 📋 Conceptos Clave
- **App Service Plan:** Define la capacidad de cómputo (CPU, RAM, SO) que sustenta la Web App.
- **Linux Web App:** Aplicación web que corre sobre Linux en el App Service Plan.
- **SKU F1 (Free):** Plan gratuito con 60 minutos de cómputo/día — solo para labs.
- **App Settings:** Variables de entorno inyectadas en la aplicación en tiempo de ejecución.

## 📁 Archivos
```
ej-az-06-app-service/
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

### Paso 2: Abrir la Web App en el navegador
```bash
# Ver la URL del output
terraform output webapp_url

# Abrir en el navegador (verás la página por defecto de Azure App Service)
```

### Paso 3: Hacer deploy de código de prueba con ZIP
```bash
# Crear un archivo app de prueba
echo 'def main(environ, start_response):
    start_response("200 OK", [("Content-Type", "text/plain")])
    return [b"Hola UTEC desde Azure App Service!"]' > app.py

zip deploy.zip app.py

az webapp deploy \
  --resource-group rg-utec-lab01 \
  --name webapp-utec-lab06 \
  --src-path deploy.zip \
  --type zip
```

### Paso 4: Destruir
```bash
terraform destroy -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
app_service_plan_id = "/subscriptions/.../serverfarms/asp-utec-lab06"
webapp_name         = "webapp-utec-lab06"
webapp_url          = "https://webapp-utec-lab06.azurewebsites.net"
```

## 📝 Notas
- El nombre de la Web App debe ser único globalmente — cambia el sufijo si hay conflicto.
- SKU `F1` (Free) no soporta custom domains ni SSL. Usa `B1` o superior para producción.
- `app_settings` son variables de entorno disponibles en tu aplicación como `os.environ["ENVIRONMENT"]`.
