resource "azurerm_resource_group" "example" {
  name     = "Angus_Ressources"
  location = "swedencentral"

  tags = {
    owner = "mario.strobl@redbull.com"
  
}
}
