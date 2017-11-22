resource "azurerm_servicebus_namespace" "namespace" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "standard"

  tags {
    source = "terraform"
  }
}
