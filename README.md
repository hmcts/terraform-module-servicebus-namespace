# terraform-module-servicebus-namespace

A Terraform module for creating an Azure Service Bus namespace.
Refer to the following link for a detailed explanation of the Azure Service Bus namespace.

[Azure Service Bus Namespace](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)

## Usage

The following example shows how to use the module to create an Azure Service Bus namespace.

```terraform
module "servicebus-namespace" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-namespace?ref=master"
  name                = "${var.product}-${var.component}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  env                 = var.env
  common_tags         = var.common_tags
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | Specifies the capacity (value must be >= 1 if using Premium SKU) | `number` | `0` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Enable Private endpoint? Only available with the Premium SKU, if set to true a Premium type Service Bus Namespace will be deployed automatically | `bool` | `false` | no |
| <a name="input_enable_public_access"></a> [enable\_public\_access](#input\_enable\_public\_access) | Enable public access (should only be enabled for a migration when using the Premium SKU and a private endpoint connection) | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"UK South"` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique Azure Service Bus namespace | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name - sds or cft | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group in which the Service Bus namespace should exist | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU type (Basic, Standard and Premium) | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `map` | <pre>{<br>  "cft": {<br>    "aat": "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/core-infra-aat/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-aat/subnets/core-infra-subnet-0-aat",<br>    "demo": "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/core-infra-demo/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-demo/subnets/core-infra-subnet-0-demo",<br>    "ithc": "/subscriptions/7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c/resourceGroups/core-infra-ithc/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-ithc/subnets/core-infra-subnet-0-ithc",<br>    "perftest": "/subscriptions/7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c/resourceGroups/core-infra-perftest/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-perftest/subnets/core-infra-subnet-0-perftest",<br>    "preview": "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/core-infra-preview/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-preview/subnets/core-infra-subnet-0-preview",<br>    "prod": "/subscriptions/8999dec3-0104-4a27-94ee-6588559729d1/resourceGroups/core-infra-prod/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-prod/subnets/core-infra-subnet-0-prod",<br>    "sbox": "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/core-infra-sandbox/providers/Microsoft.Network/virtualNetworks/core-infra-vnet-sandbox/subnets/core-infra-subnet-0-sandbox"<br>  },<br>  "sds": {<br>    "demo": "/subscriptions/c68a4bed-4c3d-4956-af51-4ae164c1957c/resourceGroups/ss-demo-network-rg/providers/Microsoft.Network/virtualNetworks/ss-demo-vnet/subnets/private-endpoints",<br>    "dev": "/subscriptions/867a878b-cb68-4de5-9741-361ac9e178b6/resourceGroups/ss-dev-network-rg/providers/Microsoft.Network/virtualNetworks/ss-dev-vnet/subnets/private-endpoints",<br>    "ithc": "/subscriptions/ba71a911-e0d6-4776-a1a6-079af1df7139/resourceGroups/ss-ithc-network-rg/providers/Microsoft.Network/virtualNetworks/ss-ithc-vnet/subnets/private-endpoints",<br>    "prod": "/subscriptions/5ca62022-6aa2-4cee-aaa7-e7536c8d566c/resourceGroups/ss-prod-network-rg/providers/Microsoft.Network/virtualNetworks/ss-prod-vnet/subnets/private-endpoints",<br>    "sbox": "/subscriptions/a8140a9e-f1b0-481f-a4de-09e2ee23f7ab/resourceGroups/ss-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/ss-sbox-vnet/subnets/private-endpoints",<br>    "stg": "/subscriptions/74dacd4f-a248-45bb-a2f0-af700dc4cf68/resourceGroups/ss-stg-network-rg/providers/Microsoft.Network/virtualNetworks/ss-stg-vnet/subnets/private-endpoints",<br>    "test": "/subscriptions/3eec5bde-7feb-4566-bfb6-805df6e10b90/resourceGroups/ss-test-network-rg/providers/Microsoft.Network/virtualNetworks/ss-test-vnet/subnets/private-endpoints"<br>  }<br>}</pre> | no |
| <a name="input_subnet_id_override"></a> [subnet\_id\_override](#input\_subnet\_id\_override) | Override default Private Endpoint subnet id | `string` | `""` | no |
| <a name="input_zoneRedundant"></a> [zoneRedundant](#input\_zoneRedundant) | Whether or not this resource is zone redundant (true or false) | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_send_and_listen_connection_string"></a> [primary\_send\_and\_listen\_connection\_string](#output\_primary\_send\_and\_listen\_connection\_string) | primary connection string for send and listen operations |
| <a name="output_primary_send_and_listen_shared_access_key"></a> [primary\_send\_and\_listen\_shared\_access\_key](#output\_primary\_send\_and\_listen\_shared\_access\_key) | primary shared access key with send and listen rights |
| <a name="output_secondary_send_and_listen_connection_string"></a> [secondary\_send\_and\_listen\_connection\_string](#output\_secondary\_send\_and\_listen\_connection\_string) | secondary connection string for send and listen operations |
| <a name="output_secondary_send_and_listen_shared_access_key"></a> [secondary\_send\_and\_listen\_shared\_access\_key](#output\_secondary\_send\_and\_listen\_shared\_access\_key) | secondary shared access key with send and listen rights |
| <a name="output_sku"></a> [sku](#output\_sku) | sku type |
<!-- END_TF_DOCS -->

Terraform docs created with: `terraform-docs markdown table --output-file README.md --hide-empty=true --output-mode inject --show providers,inputs,outputs .`
