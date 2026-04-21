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
  features {}
}

data "azurerm_resource_group" "utec_rg" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "sa_utec" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.utec_rg.name
  location                 = data.azurerm_resource_group.utec_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}

resource "azurerm_storage_container" "contenedor" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa_utec.name
  container_access_type = "private"
}
