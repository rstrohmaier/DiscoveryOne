resource "azurerm_resource_group" "example" {
  name     = "Angus_Ressources"
  location = "West Europe"

  tags = {
    environment = "Production"
  
}
}
