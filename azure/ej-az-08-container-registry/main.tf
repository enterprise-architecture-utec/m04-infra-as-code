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

resource "azurerm_container_registry" "acr_utec" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.utec_rg.name
  location            = data.azurerm_resource_group.utec_rg.location
  sku                 = var.sku
  admin_enabled       = true

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}
