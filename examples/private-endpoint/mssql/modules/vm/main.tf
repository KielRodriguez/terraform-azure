variable "location" {}
variable "rg_name" {}
variable "subnet_id" {}

resource "azurerm_public_ip" "pip" {
  name                = "vm1-public-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "nic" {
    name = "vm1-nic"
    resource_group_name = var.rg_name
    location = var.location

    ip_configuration  {
        name =  "internal"
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pip.id
    }
}

resource "azurerm_windows_virtual_machine" "vm" {
    name                = "vm1"
    resource_group_name = var.rg_name
    location            = var.location
    size                = "Standard_D2_v4"
    admin_username      = "adminuser"
    admin_password      = "P@$$w0rd1234!"
    network_interface_ids = [
        azurerm_network_interface.nic.id,
    ]

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb = 127
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter"
        version   = "latest"
    }
}