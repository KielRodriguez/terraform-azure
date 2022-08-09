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


# create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-azure-examples"
  location = "East US 2"
}

module "vnet" {
  source = "./modules/vnet"

  location = "East US 2"
  rg_name  = azurerm_resource_group.rg.name
}

module "mssql" {
  source = "./modules/mssql"

  location = "East US 2"
  rg_name  = azurerm_resource_group.rg.name
}