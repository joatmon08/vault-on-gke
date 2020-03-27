variable "project" {
  type        = string
  description = "GCP Project"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "kubernetes_cluster" {
  type        = string
  description = "Name of GKE cluster"
}

variable "kubernetes_cluster_location" {
  type        = string
  description = "Location of GKE cluster"
}

variable "namespace" {
  type        = string
  description = "Namespace for Vault cluster"
}