terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_service_plan" "service_plan" {
  name                = "sp-${var.project_name}"
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "web_app" {
  name                = "wa-${var.project_name}"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {}
}