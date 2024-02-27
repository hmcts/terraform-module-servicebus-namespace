locals {
  auth_rule_name = "SendAndListenSharedAccessKey"
  sku            = var.enable_private_endpoint == true ? "Premium" : var.sku
  capacity       = local.sku == "Premium" && var.capacity <= 0 ? 1 : var.capacity
}

resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku                          = local.sku
  zone_redundant               = var.zone_redundant
  tags                         = var.common_tags
  capacity                     = local.capacity
  premium_messaging_partitions = lower(local.sku) == "premium" ? 1 : 0
}

resource "azurerm_servicebus_namespace_authorization_rule" "send_listen_auth_rule" {
  name         = local.auth_rule_name
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  listen = true
  send   = true
}
