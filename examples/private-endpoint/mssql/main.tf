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