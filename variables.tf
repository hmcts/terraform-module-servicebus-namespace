variable "location" {
  type    = string
  default = "UK South"
}

variable "project" {
  default     = ""
  description = "Project name (required for Premium SKU) - sds or cft. "
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
  description = "Specifies the capacity. Defaults to 1 when using Premium SKU."
}

variable "zone_redundant" {
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
  default     = ""
  description = "Subnet ID to attach private endpoint to - overrides the default subnet id"
}


variable "private_endpoint_subscription_id" {
  default     = ""
  description = "Subscription ID of the subnet that the private endpoint will be created in. Only needed when creating a Service Bus with a Private Endpoint enabled and when the Subscription differs between the Service Bus and the target subnet."
}
