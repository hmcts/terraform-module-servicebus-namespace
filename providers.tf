data "azurerm_client_config" "current" {
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "private-endpoint-subnet"
  subscription_id            = var.project == "sds" ? "a8140a9e-f1b0-481f-a4de-09e2ee23f7ab" : var.aks_subscription_id
}
