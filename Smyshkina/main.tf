resource "azurerm_resource_group" "example" {
  name     = "Smyshkina_Resource_Group"
  location = "northeurope"

  tags = {
    owner = "katya.smyshliaeva@redbull.com"
  }
}