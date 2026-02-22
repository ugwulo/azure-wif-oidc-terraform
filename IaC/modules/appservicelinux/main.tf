resource "azurerm_service_plan" "app_service_plan" {
for_each = { for x in var.config1.app-service-plan : x.name => x }
  name                = each.value.name 
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name     
  os_type             = each.value.os_type
}


resource "azurerm_linux_web_app" "app_service" {
  for_each = { for x in var.config2.app-service : x.name => x }
  name                = each.value.name 
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  service_plan_id = each.value.service_plan_id 

  site_config {
    ftps_state       = each.value.site_config.ftps_state 
    always_on        = each.value.site_config.always_on 
    application_stack {
      docker_image_name = each.value.site_config.application_stack.docker_image_name
      docker_registry_url = each.value.site_config.application_stack.docker_registry_url 
    }
  }

  identity {
    type = "SystemAssigned"
  }
  
  https_only = true
  depends_on = [azurerm_service_plan.app_service_plan]
  
}