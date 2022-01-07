locals {
  policy_parameters = {
        effect = {
            value = "${var.policy_effect}"
        }
    }
}

resource "azurerm_resource_group_policy_assignment" "secure_transfer_enabled" {
    name = var.policy_assignment_name
    resource_group_id = var.resource_group_id
    policy_definition_id = var.policy_definition_id
    parameters = jsonencode(local.policy_parameters)
}