# Create a resource group
resource "azurerm_resource_group" "Rick_Sanchez_ResourceGroup" {
  name     = "Rick_Sanchez_ResourceGroup"
  location = "West Europe"
  
  tags = {
    environment = "Production"
  }
}