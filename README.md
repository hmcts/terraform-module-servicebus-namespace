# terraform-module-servicebus-namespace

A Terraform module for creating an Azure Service Bus namespace.
Refer to the following link for a detailed explanation of the Azure Service Bus namespace.

[Azure Service Bus Namespace](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)

## Usage

The following example shows how to use the module to create an Azure Service Bus namespace.

```terraform
module "servicebus-namespace" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-namespace?ref=servicebus_tf"
  name                = local.servicebus_namespace_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  env                 = var.env
  common_tags         = local.common_tags
}
```

## Variables

### Configuration

The following parameters are required by this module

- `name` the name of the ServiceBus namespace.
- `resource_group_name` the name of the resource group in which to create the ServiceBus namespace.
- `env` this is used to differentiate the environments e.g aat, demo, prod, etc.
- `common_tags` tags that need to be applied to the ServiceBus namespace

The following parameters are optional

- `location` the azure region for this service. _Note:_ Check to ensure the service is available in the region.
- `sku` defines which tier to use. Options are basic, standard or premium. Changing this forces a new resource to be created.
- `zone_redundant` whether or not this resource is zone redundant (true or false).

### Output

The following variables are provided by the module for use in other modules

- `name` the name of the service bus namespace.
- `primary_send_and_listen_connection_string` the Primary Connection String for the ServiceBus Namespace authorization Rule.
- `secondary_send_and_listen_connection_string` the Secondary Connection String for the ServiceBus Namespace authorization Rule.
- `primary_send_and_listen_shared_access_key` the Primary Key for the ServiceBus Namespace authorization Rule.
- `secondary_send_and_listen_shared_access_key` the Secondary Key for the ServiceBus Namespace authorization Rule.
- `sku` the sku of the ServiceBus.
- `zone_redundant` The zone redudancy of the ServiceBus.
