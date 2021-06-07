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
  type = number
  default = 0
  description = "Specifies the capacity"
}

variable "zoneRedundant" {
  type        = bool
  default     = false
  description = "Whether or not this resource is zone redundant (true or false)"
}