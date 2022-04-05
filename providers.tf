terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0.0"
      configuration_aliases = [ azurerm.private-endpoint ]
    }
  }
}
