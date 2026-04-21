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

# App Service Plan (define CPU/RAM del hosting)
resource "azurerm_service_plan" "asp_utec" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.utec_rg.name
  location            = data.azurerm_resource_group.utec_rg.location
  os_type             = "Linux"
  sku_name            = var.sku_name

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}

# Web App Linux con Python
resource "azurerm_linux_web_app" "webapp_utec" {
  name                = var.webapp_name
  resource_group_name = data.azurerm_resource_group.utec_rg.name
  location            = data.azurerm_resource_group.utec_rg.location
  service_plan_id     = azurerm_service_plan.asp_utec.id

  site_config {
    application_stack {
      python_version = "3.11"
    }
    always_on = false # always_on no disponible en F1
  }

  app_settings = {
    "ENVIRONMENT"          = "laboratorio"
    "COURSE"               = "Arquitectura Multinube"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
  }

  tags = {
    Entorno = "Laboratorio"
    Curso   = "Arquitectura Multinube"
  }
}
