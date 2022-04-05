
   
provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "private-endpoint-subnet"
  subscription_id            = var.private_endpoint_subscription_id
}
