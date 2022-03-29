data "azurerm_client_config" "current" {
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "private-endpoint-subnet"
  subscription_id            = var.project == "sds" ? var.subscription_id : var.aks_subscription_id
}
