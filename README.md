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

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | n/a     |

## Inputs

| Name                                                                                          | Description                                                                                                                | Type          | Default      | Required |
| --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------ | :------: |
| <a name="input_capacity"></a> [capacity](#input_capacity)                                     | Specifies the capacity (value must be >= 1 if using Premium SKU)                                                           | `number`      | `0`          |    no    |
| <a name="input_common_tags"></a> [common_tags](#input_common_tags)                            | n/a                                                                                                                        | `map(string)` | n/a          |   yes    |
| <a name="input_enable_public_access"></a> [enable_public_access](#input_enable_public_access) | Enable public access (should only be enabled for a migration when using the Premium SKU and a private endpoint connection) | `bool`        | `false`      |    no    |
| <a name="input_env"></a> [env](#input_env)                                                    | n/a                                                                                                                        | `string`      | n/a          |   yes    |
| <a name="input_location"></a> [location](#input_location)                                     | n/a                                                                                                                        | `string`      | `"UK South"` |    no    |
| <a name="input_name"></a> [name](#input_name)                                                 | Unique Azure Service Bus namespace                                                                                         | `string`      | n/a          |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name)    | Resource group in which the Service Bus namespace should exist                                                             | `string`      | n/a          |   yes    |
| <a name="input_sku"></a> [sku](#input_sku)                                                    | SKU type (Basic, Standard and Premium)                                                                                     | `string`      | `"Standard"` |    no    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)                                  | Subnet ID that need access to service bus namespace (Premium SKU only)                                                     | `string`      | `""`         |    no    |
| <a name="input_zoneRedundant"></a> [zoneRedundant](#input_zoneRedundant)                      | Whether or not this resource is zone redundant (true or false)                                                             | `bool`        | `false`      |    no    |

## Outputs

| Name                                                                                                                                                                 | Description                                                |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| <a name="output_name"></a> [name](#output_name)                                                                                                                      | n/a                                                        |
| <a name="output_primary_send_and_listen_connection_string"></a> [primary_send_and_listen_connection_string](#output_primary_send_and_listen_connection_string)       | primary connection string for send and listen operations   |
| <a name="output_primary_send_and_listen_shared_access_key"></a> [primary_send_and_listen_shared_access_key](#output_primary_send_and_listen_shared_access_key)       | primary shared access key with send and listen rights      |
| <a name="output_secondary_send_and_listen_connection_string"></a> [secondary_send_and_listen_connection_string](#output_secondary_send_and_listen_connection_string) | secondary connection string for send and listen operations |
| <a name="output_secondary_send_and_listen_shared_access_key"></a> [secondary_send_and_listen_shared_access_key](#output_secondary_send_and_listen_shared_access_key) | secondary shared access key with send and listen rights    |
| <a name="output_sku"></a> [sku](#output_sku)                                                                                                                         | sku type                                                   |

<!-- END_TF_DOCS -->

Terraform docs created with: `terraform-docs markdown table --output-file README.md --hide-empty=true --output-mode inject --show providers,inputs,outputs .`
