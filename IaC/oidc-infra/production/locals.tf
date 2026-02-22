locals {
  resource-group-env = yamldecode(file("rg-env.yaml"))
  keyvault-env = yamldecode(file("keyvault-env.yaml"))
  appservicelinux-env = yamldecode(file("appservicelinux-env.yaml"))
  acr-env = yamldecode(file("acr-env.yaml"))
}