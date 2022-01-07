
variable "policy_assignment_name" { 
    default = "audit-storage-acct-secure-transfer"
    description = "The name used to identify the resource group policy assignment."
}
variable "policy_definition_id" {
    default = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9" # Policy Definition Name 'Secure transfer to storage accounts should be enabled'
    description = "The policy definition id of the policy you would like to assign to the resource group."
}

variable "policy_effect" {
    default = "Audit"
    description = "The value of the policy's 'effect' parameter; default value of 'Audit' and allowed values of 'Audit', 'Deny', or 'Disabled'."
    validation {
        condition = var.policy_effect == "Audit" || var.policy_effect == "Deny" || var.policy_effect == "Disabled"
        error_message = "The policy_effect value must be 'Audit', 'Deny', or 'Disabled'."
    }
}