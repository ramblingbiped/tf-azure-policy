# Azure Policy Assignment with Terraform

This project's purpose is to demonstrate the application of azure policies to azure resources at both the Resource Group and Subscription scope via the use of Terraform.

<br/><br/>

## Getting Started

Access ot an Azure subscription with all of the necessary permissions to assign the referenced Azure Policies is assumed. The following tools and associated versions were used and are required dependencies:

<br/>

### Prerequisites

* Terraform Version 1.1.2 (*Terraform Installation: https://learn.hashicorp.com/tutorials/terraform/install-cli*)
* Azure CLI Version  2.32.0 (*Azure CLI Installation: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli*) 


<br/><br/>

## Assigning Policies

The included examples allow for the assignment of the built-in `Secure transfer to storage accounts should be enabled` Policy for Storage Accounts at both the Resource Group and Subscription scope. The terraform code for assigning the Policy at the Resource Group scope resides in the `resource-group-assignment/` directory, and the terraform code for assigning the policy at the Subscription scope resides in the `subscription-assignment` directory.

<br/>

### Resource Group Assignment

```bash
resource-group-assignment
├── main.tf
├── output.tf
├── policy_assignment.tf
└── variables.tf
```
**Terraform Assets**
* **`main.tf`** - contains the `azurerm` provider definition, as well as the required providers configuration.
* **`output.tf`** - contains the output the returns the id of the policy assignment upon successful terraform apply.
* **`policy_assignment.tf`** - contains the `secure_transfer_enabled` `azurerm_resource_group_policy_assignment` resource used to assign the `Secure transfer to storage accounts should be enabled` Policy.
* **`variables.tf`** - Contains four input variables; `resource_group_id`, `policy_assignemnt_name`, `policy_definition_id`, and `policy_effect`

<br/>

#### Assigning the Policy to the target Resource Group:

> The `policy_effect` variable maps to the `effect` parameter of the Policy, and dictates the state of the Policy assignment. The default value of "*Audit*" will inform on compliance, but not enforce the policy. The "*Deny*" value will enforce the policy upon assignment. The "*Disable*" value will disable the assigned policy.

<br/>

Example `my-vars.tfvars` file:

```bash
resource_group_id = "/subscriptions/${INSERT_SUB_ID}/resourceGroups/testGroup"
policy_assignment_name = "audit-storage-acct-secure-transfer"
policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
policy_effect = "Deny"
```

<br/>

Deploy the Policy assignment: 

```bash
az login
terraform plan --var-file my-vars.tfvars --out rg-assignment.plan
terraform apply rg-assignment.plan
```

<br/><br/>

### Subscription Assignment

```bash
subscription-assignment
├── main.tf
├── output.tf
├── policy_assignment.tf
└── variables.tf
```

**Terraform assets**
* **`main.tf`** - contains the `azurerm` provider definition, as well as the required providers configuration.
* **`output.tf`** - contains the output the returns the id of the policy assignment upon successful terraform apply.
* **`policy_assignment.tf`** - contains the `current` `azurerm_subscription` data resource and the `secure_transfer_enabled` `azurerm_subscription_policy_assignment` resource used to assign the `Secure transfer to storage accounts should be enabled` Policy.
* **`variables.tf`** - Contains three input variables; `policy_assignemnt_name`, `policy_definition_id`, and `policy_effect`

<br/>

#### Assigning the Policy to the target Subscription

<br/>

> The `policy_effect` variable maps to the `effect` parameter of the Policy, and dictates the state of the Policy assignment. The default value of "*Audit*" will inform on compliance, but not enforce the policy. The "*Deny*" value will enforce the policy upon assignment. The "*Disable*" value will disable the assigned policy.

<br/>

Example `my-vars.tfvars` file:

```bash
policy_assignment_name = "audit-storage-acct-secure-transfer"
policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
policy_effect = "Audit"
```

<br/>

Deploy the Policy assignment: 

```bash
az login
terraform plan --var-file my-vars.tfvars --out sub-assignment.plan
terraform apply sub-assignment.plan
```


<br/><br/>

## Resources
* `azurerm_resource_group_policy_assignment` documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment#attributes-reference
* `azurerm_subscription_policy_assignment` documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment
* How to install the Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
* Implementing Azure Policy using Terraform: https://techcommunity.microsoft.com/t5/azure-paas-blog/implementing-azure-policy-using-terraform/ba-p/1423775
* Install Terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli
* Quickstart: Create a policy assignment to identify non-compliant resources using Terraform: https://docs.microsoft.com/en-us/azure/governance/policy/assign-policy-terraform
* Terraform Variables Validation: https://jeffbrown.tech/terraform-variables-validation/