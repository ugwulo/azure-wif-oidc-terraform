variable "config" {
  type = object({
    acr = list(object({
      name                          = string
      location                      = optional(string)
      resource_group_name           = string
      sku                           = optional(string)
      admin_enabled                 = optional(string)
      public_network_access_enabled = optional(string)
      network_rule_bypass_option    = optional(string)
      georeplications = optional(list(object({
        location                = string
        zone_redundancy_enabled = optional(bool)
        tags                    = optional(map(string))
      })))
      network_rule_set = optional(object({
        default_action = string
        ip_rule = optional(list(object({
          ip_range = string
          action   = string
        })))
      }))
      tags = map(string)
    }))
  })
}