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

This example shows you how to deploy a Premium SKU Azure Service Bus with a Private Endpoint, giving it a private IP. The Private Endpoint will be attached to one of the default subnets automatically, if you need to override the default subnet ID you can with the `subnet_id` input.

```terraform
module "servicebus-namespace" {
  source                  = "git@github.com:hmcts/terraform-module-servicebus-namespace?ref=master"
  name                    = "${var.product}-${var.component}"
  resource_group_name     = azurerm_resource_group.shared_resource_group.name
  location                = var.location
  env                     = var.env
  common_tags             = var.common_tags
  project                 = var.project
  enable_private_endpoint = var.servicebus_enable_private_endpoint
}
```

<!-- BEGIN_TF_DOCS -->

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | n/a     |

## Inputs

| Name                                                                                                   | Description                                                                                                                                      | Type          | Default      | Required |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ------------ | :------: |
| <a name="input_capacity"></a> [capacity](#input_capacity)                                              | Specifies the capacity. Defaults to 1 when using Premium SKU.                                                                                    | `number`      | `0`          |    no    |
| <a name="input_common_tags"></a> [common_tags](#input_common_tags)                                     | n/a                                                                                                                                              | `map(string)` | n/a          |   yes    |
| <a name="input_enable_private_endpoint"></a> [enable_private_endpoint](#input_enable_private_endpoint) | Enable Private endpoint? Only available with the Premium SKU, if set to true a Premium type Service Bus Namespace will be deployed automatically | `bool`        | `false`      |    no    |
| <a name="input_enable_public_access"></a> [enable_public_access](#input_enable_public_access)          | Enable public access (should only be enabled for a migration when using the Premium SKU and a private endpoint connection)                       | `bool`        | `false`      |    no    |
| <a name="input_env"></a> [env](#input_env)                                                             | n/a                                                                                                                                              | `string`      | n/a          |   yes    |
| <a name="input_location"></a> [location](#input_location)                                              | n/a                                                                                                                                              | `string`      | `"UK South"` |    no    |
| <a name="input_name"></a> [name](#input_name)                                                          | Unique Azure Service Bus namespace                                                                                                               | `string`      | n/a          |   yes    |
| <a name="input_project"></a> [project](#input_project)                                                 | Project name (required for Premium SKU) - sds or cft.                                                                                            | `string`      | `""`         |    no    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name)             | Resource group in which the Service Bus namespace should exist                                                                                   | `string`      | n/a          |   yes    |
| <a name="input_sku"></a> [sku](#input_sku)                                                             | SKU type (Basic, Standard and Premium)                                                                                                           | `string`      | `"Standard"` |    no    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)                                           | Subnet ID to attach private endpoint to - overrides the default subnet id                                                                        | `string`      | `""`         |    no    |
| <a name="input_zoneRedundant"></a> [zoneRedundant](#input_zoneRedundant)                               | Whether or not this resource is zone redundant (true or false)                                                                                   | `bool`        | `false`      |    no    |

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

Terraform docs created with:

```bash
terraform-docs markdown table --output-file README.md --hide-empty=true --output-mode inject --show providers,inputs,outputs .
```
