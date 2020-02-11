#####
# Providers
#####

provider "azurerm" {
  version         = "1.28.0"
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "random" {
  version = "~> 2"
}

provider "kubernetes" {
  version                = "1.10.0"
  host                   = data.azurerm_kubernetes_cluster.this.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.this.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.this.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
  load_config_file       = false
}

#####
# Randoms
#####

resource "random_string" "default" {
  upper   = false
  number  = false
  special = false
  length  = 8
}

resource "random_string" "disabled" {
  upper   = false
  number  = false
  special = false
  length  = 8
}

#####
# Datasources
#####

data "azurerm_kubernetes_cluster" "this" {
  name                = "prometheusplusplus-stg0"
  resource_group_name = "prometheusplusplus-stg0"
}

#####
# Context
#####

resource "kubernetes_namespace" "default" {
  metadata {
    name = random_string.default.result
  }
}

resource "kubernetes_namespace" "disabled" {
  metadata {
    name = random_string.disabled.result
  }
}

#####
# default example
#####

module "default" {
  source = "../.."

  namespace  = kubernetes_namespace.default.metadata.0.name
  access_key = "fake_key"
  secret_key = "fake_secret"
}

#####
# disabled example
#####

module "disabled" {
  source = "../.."

  enabled = false

  namespace  = kubernetes_namespace.disabled.metadata.0.name
  access_key = ""
  secret_key = ""
}
