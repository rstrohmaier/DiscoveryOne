terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  # This is only required when the User, Service Principal
  # or Identity running Terraform lacks the permissions
  # to register Azure Resource Providers.
  features {}
}