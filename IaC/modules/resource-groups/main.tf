resource "azurerm_resource_group" "resource-group" {
  for_each = { for x in var.config.rg : x.name => x }
  name     =  length(each.value.rg_prefix) > 0 ? "${each.value.rg_prefix}-${each.value.name}" : each.value.name
  location = each.value.location
  tags     = {
        for k, v in each.value.tags:
    k => k == "Name" ? "${each.value.rg_prefix}-${v}" : v
  }
  lifecycle {
    create_before_destroy = true
  }

}