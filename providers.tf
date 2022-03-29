provider "azurerm" {
  features {}
  alias           = "private-endpoint-subnet"
  subscription_id = var.aks_subscription_id
}
