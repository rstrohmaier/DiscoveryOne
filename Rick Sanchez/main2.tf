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
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.location
  resource_group_name = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
}

resource "azurerm_subnet" "Rick_Sanchez_Subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.Rick_Sanchez_ResourceGroup_New.name
  virtual_network_name = azurerm_virtual_network.Rick_Sanchez_VirtualNetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}