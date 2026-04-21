terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Obtener informacion del usuario/servicio autenticado
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "utec_rg" {
  name = var.resource_group_name
}

# Key Vault
resource "azurerm_key_vault" "kv_utec" {
  name                       = var.key_vault_name
  location                   = data.azurerm_resource_group.utec_rg.location
  resource_group_name        = data.azurerm_resource_group.utec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  # Politica de acceso para el usuario/servicio que ejecuta Terraform
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]

    key_permissions = [
      "Get", "List", "Create", "Delete"
    ]
  }

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}

# Secreto: contrasena de base de datos
resource "azurerm_key_vault_secret" "secreto_db" {
  name         = "db-password"
  value        = var.db_password
  key_vault_id = azurerm_key_vault.kv_utec.id

  content_type = "text/plain"
}

# Secreto: API Key de ejemplo
resource "azurerm_key_vault_secret" "api_key" {
  name         = "api-key-ejemplo"
  value        = "clave-api-ejemplo-utec-2024"
  key_vault_id = azurerm_key_vault.kv_utec.id

  content_type = "text/plain"
}
