locals {
  use_default_subnet_id = var.subnet_id == "" ? true : false
}

data "azurerm_subnet" "private-endpoints" {
  count    = var.enable_private_endpoint && local.use_default_subnet_id ? 1 : 0
  provider = azurerm.aks

  resource_group_name  = "${var.project}-${var.env}-network-rg"
  virtual_network_name = "${var.project}-${var.env}-vnet"
  name                 = "private-endpoints"
}

resource "azurerm_private_endpoint" "this" {
  count = var.enable_private_endpoint ? 1 : 0

  name                = "${var.name}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.use_default_subnet_id ? data.azurerm_subnet.private-endpoints[0].id : var.subnet_id

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
  count                         = var.enable_private_endpoint ? 1 : 0
  namespace_id                  = azurerm_servicebus_namespace.servicebus_namespace.id
  default_action                = "Allow"
  public_network_access_enabled = var.enable_public_access

}
