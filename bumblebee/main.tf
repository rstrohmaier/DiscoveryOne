resource "azurerm_resource_group" "RGDiscoveryOne" {
  name     = "RGDiscoveryOne"
  location = "West US"

  tags = {
    environment = "Production"
  }
}