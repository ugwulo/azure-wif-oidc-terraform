resource "azurerm_key_vault" "key-vault" {
  for_each                    = { for x in var.config.key-vault : x.name => x }
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  tenant_id                   = each.value.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  rbac_authorization_enabled   = each.value.enable_rbac_authorization
  sku_name                    = each.value.sku_name
  public_network_access_enabled = each.value.public_network_access_enabled


  tags = each.value.tags
}