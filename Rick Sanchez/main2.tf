# Create a resource group
resource "azurerm_resource_group" "Rick_Sanchez_ResourceGroup_New" {
  name     = "Rick_Sanchez_RG_New"
  location = "West Europe"
  
  tags = {
    environment = "Production"
    owner = "michael.herbsthofer@redbull.com"
  }
}