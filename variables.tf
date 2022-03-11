variable "location" {
  type    = string
  default = "UK South"
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

variable "subnet_acl" {
  default     = []
  description = "List subnet IDs that need access to service bus namespace (Premium SKU only)"
}
