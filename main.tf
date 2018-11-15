# ARM template for Service Bus namespace
data "template_file" "namespace_template" {
  template = "${file("${path.module}/template/namespace_template.json")}"
}

# Create Azure Service Bus namespace
resource "azurerm_template_deployment" "namespace" {
  template_body       = "${data.template_file.namespace_template.rendered}"
  name                = "${var.name}"
  deployment_mode     = "Incremental"
  resource_group_name = "${var.resource_group_name}"

  parameters = {
    serviceBusNamespaceName = "${var.name}"
    location                = "${var.location}"
    teamName                = "${lookup(var.common_tags, "Team Name")}"
    env                     = "${var.env}"  
  }
}
