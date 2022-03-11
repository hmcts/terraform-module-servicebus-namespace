data "azurerm_subnet" "this" {
  name                 = "core-infra-subnet-0-${var.env}"
  resource_group_name  = "core-infra-${var.env}"
  virtual_network_name = "core-infra-vnet-${var.env}"
}

resource "azurerm_private_endpoint" "this" {

  count = var.subnet_acl == [] ? 0 : 1

  name                = "${var.name}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.servicebus

  private_service_connection {
    name                           = "${var.name}-endpoint-namespace"
    private_connection_resource_id = azurerm_servicebus_namespace.servicebus_namespace.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "servicebus-endpoint-dnszonegroup"
    private_dns_zone_ids = ["/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"]
  }

  tags = var.common_tags
}

resource "azurerm_servicebus_namespace_network_rule_set" "this" {
  count                         = var.subnet_acl == [] ? 0 : 1
  namespace_id                  = azurerm_servicebus_namespace.servicebus_namespace.id
  default_action                = "Deny"
  public_network_access_enabled = var.enable_public_access


  dynamic "network_rules" {
    for_each = toset(var.subnet_acl)
    content {
      subnet_id                            = network_rules.value
      ignore_missing_vnet_service_endpoint = false
    }
  }

}