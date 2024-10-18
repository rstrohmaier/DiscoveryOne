resource "azurerm_resource_group" "RGDiscoveryOne" {
  name     = "RG_bumblebee"
  location = "West US"

  tags = {
    environment = "Production"
    owner = "ramona.strohmaier@redbull.com"
  }
}