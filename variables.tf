variable "location" {
  type    = string
  default = "UK South"
}

variable "project" {
  default     = ""
  description = "Project name - sds or cft"
}

variable "name" {
  type        = string
  description = "Unique Azure Service Bus namespace"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which the Service Bus namespace should exist"
}

variable "env" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "SKU type (Basic, Standard and Premium)"
}

variable "capacity" {
  type        = number
  default     = 0
  description = "Specifies the capacity (value must be >= 1 if using Premium SKU)"
}

variable "zoneRedundant" {
  type        = bool
  default     = false
  description = "Whether or not this resource is zone redundant (true or false)"
}

variable "enable_public_access" {
  type        = bool
  default     = false
  description = "Enable public access (should only be enabled for a migration when using the Premium SKU and a private endpoint connection)"
}

variable "enable_private_endpoint" {
  default     = false
  description = "Enable Private endpoint? Only available with the Premium SKU, if set to true a Premium type Service Bus Namespace will be deployed automatically"
}

variable "subnet_id" {
  default = {
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

variable "subnet_id_override" {
  default     = ""
  description = "Override default Private Endpoint subnet id"
}
