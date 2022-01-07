data "azurerm_subscription" "current" { }

locals {
  policy_parameters = {
        effect = {
            value = "${var.policy_effect}"
        }
    }
}

resource "azurerm_subscription_policy_assignment" "secure_transfer_enabled" {
    name = var.policy_assignment_name
    subscription_id = data.azurerm_subscription.current.id
    policy_definition_id = var.policy_definition_id
    parameters = jsonencode(local.policy_parameters)
}