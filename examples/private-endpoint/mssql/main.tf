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
  name     = "rg-azure-labs"
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

module "privateendpoint" {
  source = "./modules/privateendpoint"

  location        = "East US 2"
  mssql_server_id = module.mssql.mssql_server_id
  subnet_id       = module.vnet.mssql_subnet_id
  rg_name         = azurerm_resource_group.rg.name
  vnet_id         = module.vnet.vnet_id
}

module "vm" {
  source = "./modules/vm"

  location = "East US 2"
  rg_name  = azurerm_resource_group.rg.name

  subnet_id = module.vnet.default_subnet_id
}