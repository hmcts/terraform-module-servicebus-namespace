locals {
  subnet_id = var.subnet_id != "" ? var.subnet_id : local.default_subnet_ids[var.project][var.env]

  default_subnet_ids = {
    cft = {
      sbox     = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/core-infra-sandbox/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-sandbox/subnets/core-infra-subnet-0-sandbox"
      preview  = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/core-infra-preview/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-preview/subnets/core-infra-subnet-0-preview"
      perftest = "/subscriptions/7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c/resourceGroups/core-infra-perftest/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-perftest/subnets/core-infra-subnet-0-perftest"
      ithc     = "/subscriptions/7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c/resourceGroups/core-infra-ithc/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-ithc/subnets/core-infra-subnet-0-ithc"
      demo     = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/core-infra-demo/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-demo/subnets/core-infra-subnet-0-demo"
      aat      = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/core-infra-aat/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-aat/subnets/core-infra-subnet-0-aat"
      prod     = "/subscriptions/8999dec3-0104-4a27-94ee-6588559729d1/resourceGroups/core-infra-prod/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-prod/subnets/core-infra-subnet-0-prod"
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
  subnet_id           = local.subnet_id

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
