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

# Referencia al Resource Group existente
data "azurerm_resource_group" "utec_rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet_utec" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = data.azurerm_resource_group.utec_rg.location
  resource_group_name = data.azurerm_resource_group.utec_rg.name

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}

resource "azurerm_subnet" "subnet_privada" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.utec_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_utec.name
  address_prefixes     = [var.subnet_cidr]
}
