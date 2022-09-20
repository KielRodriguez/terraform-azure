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

resource "azurerm_virtual_network" "vnet" {
    name = "vnet-${var.project_name}"
    address_space = ["10.0.0.0/16"]
    location = var.location
    resource_group_name = var.rg_name
}

resource "azurerm_subnet" "default" {
    name = "default"
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.0/24"]
}

output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
}

output "default_subnet_id" {
    value = azurerm_subnet.default.id
}