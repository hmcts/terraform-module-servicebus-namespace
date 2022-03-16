locals {
  auth_rule_name = "SendAndListenSharedAccessKey"
  capacity       = var.enable_private_endpoint && var.capacity <= 0 ? 1 : var.capacity
}

resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.enable_private_endpoint ? "Premium" : var.sku
  zone_redundant      = var.zoneRedundant
  tags                = var.common_tags
  capacity            = local.capacity
}

resource "azurerm_servicebus_namespace_authorization_rule" "send_listen_auth_rule" {
  name                = local.auth_rule_name
  namespace_name      = azurerm_servicebus_namespace.servicebus_namespace.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
}
