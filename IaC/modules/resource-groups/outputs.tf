output "resource_group_names" {
  value = { for key, rg in azurerm_resource_group.resource-group : key => rg.name }
}