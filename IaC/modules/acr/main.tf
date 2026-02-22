resource "azurerm_container_registry" "acr" {
  for_each                      = { for x in var.config.acr : x.name => x }
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = coalesce(each.value.location, "UK South")
  sku                           = coalesce(each.value.sku, "Premium")
  admin_enabled                 = coalesce(each.value.admin_enabled, "false")
  public_network_access_enabled = coalesce(each.value.public_network_access_enabled, "false")
  network_rule_bypass_option    = each.value.network_rule_bypass_option
  dynamic "network_rule_set" {
    for_each = each.value.network_rule_set == null ? [] : [each.value.network_rule_set]
    content {
      default_action = network_rule_set.value.default_action
      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rule == null ? [] : network_rule_set.value.ip_rule
        content {
          ip_range = ip_rule.value.ip_range
          action   = ip_rule.value.action
        }
      }
    }
  }
  dynamic "georeplications" {
    for_each = each.value.georeplications == null ? [] : each.value.georeplications
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
      tags                    = georeplications.value.tags
    }

  }
  identity {
    type = "SystemAssigned"
  }

  tags = each.value.tags
}