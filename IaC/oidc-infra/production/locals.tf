locals {
  resource-group-env = yamldecode(file("rg-env.yaml"))
  appservicelinux-env = yamldecode(file("appservicelinux-env.yaml"))
}