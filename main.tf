data "azurerm_client_config" "current" {}

locals {
  root_management_group_id = var.root_management_group_id != "" ? var.root_management_group_id : data.azurerm_client_config.current.tenant_id
  root_mg_scope            = "/providers/Microsoft.Management/managementGroups/${local.root_management_group_id}"
}

resource "azurerm_role_definition" "contributor_no_delete" {
  name        = "Contributor-No-Delete"
  scope       = local.root_mg_scope
  description = "Contributor-like access with delete operations blocked"

  permissions {
    actions = ["*"]

    # Blocks control plane delete operations across providers.
    not_actions = ["*/delete"]
  }

  assignable_scopes = [local.root_mg_scope]
}

resource "azurerm_role_assignment" "contributor_no_delete_assignment" {
  scope              = local.root_mg_scope
  role_definition_id = azurerm_role_definition.contributor_no_delete.role_definition_resource_id
  principal_id       = var.principal_object_id
}
