locals {
  use_default_subnet_id = var.subnet_id == "" ? true : false

  default_subnet_ids = {
    cft = {
      sbox     = "/subscriptions/b72ab7b7-723f-4b18-b6f6-03b0f2c6a1bb/resourceGroups/cft-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/cft-sbox-vnet/subnets/private-endpoints"
      preview  = "/subscriptions/8b6ea922-0862-443e-af15-6056e1c9b9a4/resourceGroups/cft-preview-network-rg/providers/Microsoft.Network/virtualNetworks/cft-preview-vnet/subnets/private-endpoints"
      perftest = "/subscriptions/8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c/resourceGroups/cft-perftest-network-rg/providers/Microsoft.Network/virtualNetworks/cft-perftest-vnet/subnets/private-endpoints"
      ithc     = "/subscriptions/62864d44-5da9-4ae9-89e7-0cf33942fa09/resourceGroups/cft-ithc-network-rg/providers/Microsoft.Network/virtualNetworks/cft-ithc-vnet/subnets/private-endpoints"
      demo     = "/subscriptions/d025fece-ce99-4df2-b7a9-b649d3ff2060/resourceGroups/cft-demo-network-rg/providers/Microsoft.Network/virtualNetworks/cft-demo-vnet/subnets/private-endpoints"
      aat      = "/subscriptions/96c274ce-846d-4e48-89a7-d528432298a7/resourceGroups/cft-aat-network-rg/providers/Microsoft.Network/virtualNetworks/cft-aat-vnet/subnets/private-endpoints"
      prod     = "/subscriptions/8cbc6f36-7c56-4963-9d36-739db5d00b27/resourceGroups/cft-prod-network-rg/providers/Microsoft.Network/virtualNetworks/cft-prod-vnet/subnets/private-endpoints"
    }
    sds = {
      sbox = "/subscriptions/a8140a9e-f1b0-481f-a4de-09e2ee23f7ab/resourceGroups/ss-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/ss-sbox-vnet/subnets/private-endpoints"
      dev  = "/subscriptions/867a878b-cb68-4de5-9741-361ac9e178b6/resourceGroups/ss-dev-network-rg/providers/Microsoft.Network/virtualNetworks/ss-dev-vnet/subnets/private-endpoints"
      demo = "/subscriptions/c68a4bed-4c3d-4956-af51-4ae164c1957c/resourceGroups/ss-demo-network-rg/providers/Microsoft.Network/virtualNetworks/ss-demo-vnet/subnets/private-endpoints"
      test = "/subscriptions/3eec5bde-7feb-4566-bfb6-805df6e10b90/resourceGroups/ss-test-network-rg/providers/Microsoft.Network/virtualNetworks/ss-test-vnet/subnets/private-endpoints"
      ithc = "/subscriptions/ba71a911-e0d6-4776-a1a6-079af1df7139/resourceGroups/ss-ithc-network-rg/providers/Microsoft.Network/virtualNetworks/ss-ithc-vnet/subnets/private-endpoints"
      stg  = "/subscriptions/74dacd4f-a248-45bb-a2f0-af700dc4cf68/resourceGroups/ss-stg-network-rg/providers/Microsoft.Network/virtualNetworks/ss-stg-vnet/subnets/private-endpoints"
      prod = "/subscriptions/5ca62022-6aa2-4cee-aaa7-e7536c8d566c/resourceGroups/ss-prod-network-rg/providers/Microsoft.Network/virtualNetworks/ss-prod-vnet/subnets/private-endpoints"
    }
  }
}

resource "azurerm_private_endpoint" "this" {
  count = var.enable_private_endpoint ? 1 : 0

  name                = "${var.name}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.use_default_subnet_id ? local.default_subnet_ids[var.project][var.env] : var.subnet_id

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
