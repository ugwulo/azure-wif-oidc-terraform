# Resource Group Module
module "resource_group" {
  source = "../../modules/resource-groups"
   config = local.resource-group-env.rg
}


# App Service Linux Module
module "app_service_plan_linux" {
  source = "../../modules/appservicelinux"
  config1 = local.appservicelinux-env.appservice-plan
  config2 = local.appservicelinux-env.appservice-plan
  depends_on = [ module.resource_group ]
}