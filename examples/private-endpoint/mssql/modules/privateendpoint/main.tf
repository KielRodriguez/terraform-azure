variable "location" {}
variable "rg_name" {}
variable "mssql_server_id" {}
variable "subnet_id" {}
variable "vnet_id" {}


resource "azurerm_private_dns_zone" "privatedns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatedns-link" {
  name = "default"
  resource_group_name = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.privatedns.name
  virtual_network_id = var.vnet_id
}



resource "azurerm_private_endpoint" "pe" {
  name                = "pe-greatnameserver"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatedns.id]
  }
  
  private_service_connection {
    name                           = "greateserver-privateserviceconnection"
    is_manual_connection           = false
    private_connection_resource_id = var.mssql_server_id
    subresource_names              = ["sqlServer"]
  }
}