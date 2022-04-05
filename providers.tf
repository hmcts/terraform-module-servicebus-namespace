
   
provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "private-endpoint"
  subscription_id            = var.private_endpoint_subscription_id
}
