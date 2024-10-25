resource "azurerm_resource_group" "RG_bumblebee3" {
  name     = "RG_bumblebee3"
  location = "West US"

  tags = {
    environment = "Production"
    owner = "ramona.strohmaier@redbull.com"
  }
}

resource "azurerm_virtual_network" "RG_bumblebee3" {
  name                = "RG_bumblebee3-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG_bumblebee3.location
  resource_group_name = azurerm_resource_group.RG_bumblebee3.name
}

resource "azurerm_subnet" "RG_bumblebee3" {
  name                 = "examRG_bumblebee3ple-subnet"
  resource_group_name  = azurerm_resource_group.RG_bumblebee3.name
  virtual_network_name = azurerm_virtual_network.RG_bumblebee3.name
  address_prefixes     = ["10.0.1.0/24"]
  }
resource "azurerm_network_interface" "RG_bumblebee3" {
  name                = "RG_bumblebee3-nic"
  location            = azurerm_resource_group.RG_bumblebee3.location
  resource_group_name = azurerm_resource_group.RG_bumblebee3.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.RG_bumblebee3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "RG_bumblebee3" {
  name                = "RGbumblebee3-machine"
  resource_group_name = azurerm_resource_group.RG_bumblebee3.name
  location            = azurerm_resource_group.RG_bumblebee3.location
  size                = "Standard_F2"
    admin_username     = "username"
  admin_password     = "34FDA$#214f"  # For demonstration purposes only. Use secure methods for production.
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.RG_bumblebee3.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}