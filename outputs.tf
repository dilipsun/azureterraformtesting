output "root_management_group_scope" {
  value = local.root_mg_scope
}

output "custom_role_definition_id" {
  value = azurerm_role_definition.contributor_no_delete.role_definition_resource_id
}
