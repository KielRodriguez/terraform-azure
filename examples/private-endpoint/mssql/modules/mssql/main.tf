variable "location" {}
variable "rg_name" {}

resource "azurerm_mssql_server" "server" {
    name = "greatservername"
    resource_group_name = var.rg_name
    location = var.location
    version = "12.0"
    administrator_login = "AdminUser"
    administrator_login_password = "1234SomePassword"

}

resource "azurerm_mssql_database" "database" {
    name = "database1"
    server_id = azurerm_mssql_server.server.id
    collation = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    sku_name = "Basic"
}