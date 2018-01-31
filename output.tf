# primary connection string for send and listen operations
output "primary_send_and_listen_connection_string" {
  value = "${azurerm_template_deployment.namespace.outputs["primaryConnectionStringForSendAndListen"]}"
}

# secondary connection string for send and listen operations
output "secondary_send_and_listen_connection_string" {
  value = "${azurerm_template_deployment.namespace.outputs["secondaryConnectionStringForSendAndListen"]}"
}

# primary shared access key with send and listen rights
output "primary_send_and_listen_shared_access_key" {
  value = "${azurerm_template_deployment.namespace.outputs["primarySharedAccessKeyForSendAndListen"]}"
}

# secondary shared access key with send and listen rights
output "secondary_send_and_listen_shared_access_key" {
  value = "${azurerm_template_deployment.namespace.outputs["secondarySharedAccessKeyForSendAndListen"]}"
}
