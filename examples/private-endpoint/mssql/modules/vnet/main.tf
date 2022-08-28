variable "location" {}
variable "rg_name" {}

resource "azurerm_virtual_network" "vnet" {
    name = "virtual-network"
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
resource "azurerm_subnet" "mssql" {
    name = "mssql"
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]
    enforce_private_link_endpoint_network_policies = true
}



output "default_subnet_id" {
    value = azurerm_subnet.default.id
}

output "mssql_subnet_id" {
    value = azurerm_subnet.mssql.id
}