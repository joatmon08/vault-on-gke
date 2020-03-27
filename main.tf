terraform {
  required_version = ">=0.12"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "hashicorp-team-da-beta"

    workspaces {
      name = "vault-on-gcp"
    }
  }
}

module "vault" {
  source                      = "app.terraform.io/hashicorp-team-da-beta/vaulthelm/google"
  version                     = "0.9.0"
  project                     = var.project
  region                      = var.region
  kubernetes_cluster          = var.kubernetes_cluster
  kubernetes_cluster_location = var.kubernetes_cluster_location
  namespace                   = var.namespace
}