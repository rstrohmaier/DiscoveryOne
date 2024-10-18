# Create a resource group
resource "azurerm_resource_group" "Rick_Sanchez_ResourceGroup_New" {
  name     = "Rick_Sanchez_RG_New"
  location = "West Europe"
  
  tags = {
    environment = "Production"
    owner = "michael.herbsthofer@redbull.com"
  }
}

resource "azurerm_virtual_network" "Rick_Sanchez_VirtualNetwork" {
  name                = "RickSanchez-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.location
  resource_group_name = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
}

resource "azurerm_subnet" "Rick_Sanchez_Subnet" {
  name                 = "RickSanchez-subnet"
  resource_group_name  = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
  virtual_network_name = azurerm_virtual_network.Rick_Sanchez_VirtualNetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_interface" "Rick_Sanchez_NIC" {
  name                = "RickSanchez-nic"
  location            = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.location
  resource_group_name = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Rick_Sanchez_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
  resource "azurerm_public_ip" "Rick_Sanchez_PIP" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
  location            = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
  }

resource "azurerm_windows_virtual_machine" "example" {
  name                = "RickSanchez-machine"
  resource_group_name = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
  location            = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.location
  size                = "Standard_D2_v4"
  network_interface_ids = [
    azurerm_network_interface.Rick_Sanchez_NIC.id,
  ]
  admin_username     = "RickSanchez"
  admin_password     = "GetWrecked99"  # For demonstration purposes only. Use secure methods for production.



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "win11-23h2-avd"
    version   = "latest"
  }
}