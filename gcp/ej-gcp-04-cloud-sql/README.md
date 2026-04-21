# EJ-GCP-04: Crear una Cloud SQL (PostgreSQL)

## 🎯 Objetivo
Aprovisionar una instancia Cloud SQL con PostgreSQL 15, una base de datos y un usuario usando Terraform. Cloud SQL es el servicio de base de datos relacional administrado de GCP.

## 📋 Conceptos Clave
- **Cloud SQL:** Base de datos relacional administrada en GCP (MySQL, PostgreSQL, SQL Server).
- **`db-f1-micro`:** Tipo de instancia más pequeño disponible en Cloud SQL — ideal para laboratorios.
- **`deletion_protection = false`:** Permite eliminar la instancia con Terraform (solo para labs).
- **Cloud SQL Auth Proxy:** Herramienta recomendada para conexiones seguras desde aplicaciones.

## 📁 Archivos
```
ej-gcp-04-cloud-sql/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 🚀 Pasos

### Paso 1: Habilitar la API de Cloud SQL
```bash
gcloud services enable sqladmin.googleapis.com
```

### Paso 2: Aplicar
```bash
terraform init
terraform plan -var="project_id=<TU_PROJECT_ID>"
terraform apply -var="project_id=<TU_PROJECT_ID>" -auto-approve
# ⏱️ Cloud SQL tarda entre 5-10 minutos en estar disponible
```

### Paso 3: Conectarse con Cloud SQL Auth Proxy
```bash
# Instalar Cloud SQL Auth Proxy
curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.6.0/cloud-sql-proxy.linux.amd64
chmod +x cloud-sql-proxy

# Obtener el connection name
CONNECTION=$(terraform output -raw sql_connection_name)

# Iniciar el proxy (en segundo plano)
./cloud-sql-proxy $CONNECTION --port=5432 &

# Conectarse con psql
psql -h 127.0.0.1 -p 5432 -U adminutec -d utecdb
# Password: P@ssw0rd1234!
```

### Paso 4: Ejecutar consultas de prueba
```sql
\l                          -- Listar bases de datos
\c utecdb                   -- Conectarse a la BD
CREATE TABLE estudiantes (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  email VARCHAR(150)
);
INSERT INTO estudiantes (nombre, email) VALUES ('Juan Perez', 'juan@utec.edu.pe');
SELECT * FROM estudiantes;
```

### Paso 5: Destruir
```bash
terraform destroy -var="project_id=<TU_PROJECT_ID>" -auto-approve
```

## ✅ Resultado Esperado
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
database_name       = "utecdb"
sql_connection_name = "mi-proyecto:us-central1:sql-utec-lab04"
sql_instance_name   = "sql-utec-lab04"
sql_public_ip       = "34.X.X.X"
```

## 📝 Notas
- **Nunca** expongas Cloud SQL con `0.0.0.0/0` en producción — usa Cloud SQL Auth Proxy o Private IP.
- `db-f1-micro` no está en el Free Tier de GCP — genera costos bajos pero reales.
- En producción usa `deletion_protection = true` para evitar eliminaciones accidentales.
