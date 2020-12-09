local {
  local_tags = {
    "displayName" = "Service Bus Namespace"
    "environment" = var.env
    "Team Name"   = lookup(var.common_tags, "managedBy")
  }

  tags = merge(local.local_tags, var.common_tags)

  auth_rule_name = "SendAndListenSharedAccessKey"
}

resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  zone_redundant      = var.zone_redundant
  tags                = local.tags
}

resource "azurerm_servicebus_namespace_authorization_rule" "servicebus_authorization_rule" {
  name                = local.auth_rule_name
  namespace_name      = azurerm_servicebus_namespace.servicebus_namespace.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
}