# Resource Group Module
module "resource_group" {
  source = "../../modules/resource-groups"
   config = local.resource-group-env.rg
}

# Azure Key Vault Module
module "key-vault" {
  source = "../../modules/key-vault"
  config = local.keyvault-env.vault
  depends_on = [ module.resource_group ]
}

# Azure Container Registry Module
module "acr" {
  source = "../../modules/acr"
  config = local.acr-env.registry
}

# App Service Linux Module
module "app_service_plan_linux" {
  source = "../../modules/appservicelinux"
  config1 = local.appservicelinux-env.appservice-plan
  config2 = local.appservicelinux-env.appservice-plan
  depends_on = [ module.acr ]
}