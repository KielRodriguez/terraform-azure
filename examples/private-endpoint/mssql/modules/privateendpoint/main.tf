variable "location" {}
variable "rg_name" {}
variable "mssql_server_id" {}
variable "subnet_id" {}

resource "azurerm_network_interface" "nic" {
    name = "pe-greatnameserver-nic"
    resource_group_name = var.rg_name
    location = var.location

    ip_configuration  {
        name =  "internal"
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_private_endpoint" "pe" {
  name                = "pe-greatnameserver"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "private-mssql-connection"
    is_manual_connection           = false
    private_connection_resource_id = var.mssql_server_id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_private_dns_zone" "private_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}