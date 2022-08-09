variable "location" {}
variable "rg_name" {}

resource "azurerm_virtual_network" "vnet" {
    name = "virtual-network"
    address_space = ["10.0.0.0/16"]
    location = var.location
    resource_group_name = var.rg_name
}

resource "azurerm_subnet" "mssql" {
    name = "mssql"
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.0/24"]
}