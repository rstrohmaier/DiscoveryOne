# We strongly recommend using the required_providers block to set the
 
terraform {
  cloud {
    organization = "DiscoveryOne"
    workspaces {
      name = "DiscoveryOne"
    }
  }
 
  required_version = ">= 1.1.0"
}
 
provider "azurerm" {
  features {}
}
 
 # Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
