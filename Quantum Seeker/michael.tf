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
 


 module "RickSanchez-vm" {
  source                        = "./Module/VM"
  nic_name                      = "RickSanchezVM-nic"
  location                      = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.location
  resource_group_name           = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
  subnet_id                   = azurerm_subnet.Rick_Sanchez_Subnet.id
  # when using vnet module:
  // subnet_id                     = module.belka-vnet.subnet_id
  vm_name                       = "RickSanchezVM"
  vm_size                       = "Standard_DS1_v2"
  os_disk_name                  = "example-os-disk"
  image_publisher               = "Canonical"
  image_offer                   = "UbuntuServer"
  image_sku                     = "18.04-LTS"
  image_version                 = "latest"
  computer_name                 = "hostname"
  admin_username                = "adminuser"
  admin_password                = "Password1234!"
  disable_password_authentication = false
}