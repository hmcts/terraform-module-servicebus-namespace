locals {
  use_default_subnet_id      = var.subnet_id == "" ? true : false
  private_endpoint_rg_name   = var.project == "sds" ? "ss-${local.network_env}-network-rg" : "${var.project}-${local.network_env}-network-rg"
  private_endpoint_vnet_name = var.project == "sds" ? "ss-${local.network_env}-vnet" : "${var.project}-${local.network_env}-vnet"
  network_env                = var.env == "sandbox" ? "preview" : var.env
}

data "azurerm_subnet" "private_endpoints" {
  count    = var.enable_private_endpoint && local.use_default_subnet_id ? 1 : 0
  provider = azurerm.private_endpoint

  resource_group_name  = local.private_endpoint_rg_name
  virtual_network_name = local.private_endpoint_vnet_name
  name                 = "private-endpoints"
}

resource "azurerm_private_endpoint" "this" {
  count    = var.enable_private_endpoint ? 1 : 0
  provider = azurerm.private_endpoint

  name                = "${var.name}-endpoint"
  location            = var.location
  resource_group_name = local.private_endpoint_rg_name
  subnet_id           = local.use_default_subnet_id ? data.azurerm_subnet.private_endpoints[0].id : var.subnet_id

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
