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
module "bumbleebee3-vm" {
  source                        = "./Module/VM"
  nic_name                      = "vm-nic"
  location                      = azurerm_resource_group.RG_bumblebee3.location
  resource_group_name           = azurerm_resource_group.RG_bumblebee3.name
  subnet_id                   = azurerm_subnet.RG_bumblebee3.id
  # when using vnet module:
  // subnet_id                     = module.bumbleebee3-vnet.subnet_id
  vm_name                       = "vm-bumblebee"
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