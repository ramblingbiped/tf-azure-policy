
variable "resource_group_id" { }

variable "policy_assignment_name" { 
    default = "audit-storage-acct-secure-transfer"
}
variable "policy_definition_id" {
    default = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9" # Policy Definition Name 'Secure transfer to storage accounts should be enabled'
}

variable "policy_effect" {
    default = "Audit"
    validation {
        condition = var.policy_effect == "Audit" || var.policy_effect == "Deny" || var.policy_effect == "Disabled"
        error_message = "The policy_effect value must be 'Audit', 'Deny', or 'Disabled'."
    }
}