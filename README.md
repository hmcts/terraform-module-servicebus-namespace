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
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to attach private endpoint to - overrides the default subnet id | `string` | `""` | no |
| <a name="input_subnet_id_override"></a> [subnet\_id\_override](#input\_subnet\_id\_override) | n/a | `string` | `""` | no |
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
