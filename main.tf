locals {
  auth_rule_name               = "SendAndListenSharedAccessKey"
  sku                          = var.enable_private_endpoint == true ? "Premium" : var.sku
  enable_public_access         = var.enable_private_endpoint == true && var.enable_public_access == false ? false : var.enable_public_access
  capacity                     = local.sku != "Premium" ? 0 : local.sku == "Premium" && var.capacity <= 0 ? 1 : var.capacity
  premium_messaging_partitions = local.sku != "Premium" ? 0 : local.sku == "Premium" && var.premium_messaging_partitions <= 0 ? 1 : var.premium_messaging_partitions

  allowed_roles = [
    "Azure Service Bus Data Sender",
    "Azure Service Bus Data Receiver",
    "Azure Service Bus Data Owner"
  ]

  role_assignments = [
    for role in var.role_assignments : role if contains(local.allowed_roles, role)
  ]
}

resource "azurerm_role_assignment" "service-bus-role-assignment" {
  for_each = (var.enable_managed_identity && var.managed_identity_object_id != null) ? toset(local.role_assignments) : toset([])
  scope                = azurerm_servicebus_namespace.servicebus_namespace.id
  role_definition_name = each.value
  principal_id         = var.managed_identity_object_id
}


resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = local.sku
  tags                          = var.common_tags
  capacity                      = local.capacity
  premium_messaging_partitions  = local.premium_messaging_partitions
  public_network_access_enabled = local.enable_public_access

  dynamic "network_rule_set" {
    for_each = var.enable_private_endpoint ? [1] : []
    content {
      default_action                = "Allow"
      public_network_access_enabled = local.enable_public_access
    }
  }

  dynamic "identity" {
    for_each = var.enable_managed_identity ? [1] : []

    content {
      type = "UserAssigned"
      identity_ids = toset(var.managed_identity_resource_id)
    }
  }
}

resource "azurerm_servicebus_namespace_authorization_rule" "send_listen_auth_rule" {
  name         = local.auth_rule_name
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  listen = true
  send   = true
}
