output "name" {
  value = "${azurerm_template_deployment.namespace.name}"
}

# primary connection string for send and listen operations
output "primary_send_and_listen_connection_string" {
  value = "${azurerm_template_deployment.namespace.outputs["primarySendAndListenConnectionString"]}"
}

# secondary connection string for send and listen operations
output "secondary_send_and_listen_connection_string" {
  value = "${azurerm_template_deployment.namespace.outputs["secondarySendAndListenConnectionString"]}"
}

# primary shared access key with send and listen rights
output "primary_send_and_listen_shared_access_key" {
  value = "${azurerm_template_deployment.namespace.outputs["primarySendAndListenSharedAccessKey"]}"
}

# secondary shared access key with send and listen rights
output "secondary_send_and_listen_shared_access_key" {
  value = "${azurerm_template_deployment.namespace.outputs["secondarySendAndListenSharedAccessKey"]}"
}

# sku type
output "sku" {
  value = "${var.sku}"
}

# zoneRedundant
output "zoneRedundant" {
  value = "${var.zoneRedundant}"
}

