variable "location" {
  type = "string"
  default = "UK South"
}

variable "name" {
  type = "string"
  description = "Unique Azure Service Bus namespace"
}

variable "resource_group_name" {
  type = "string"
  description = "Resource group in which the Service Bus namespace should exist"
}
