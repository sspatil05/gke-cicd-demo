terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }

  # For team/enterprise use, move state to a GCS bucket:
  # Each environment keeps its own state under its own prefix.
  # backend "gcs" {
  #   bucket = "<state-bucket>"
  #   prefix = "gke/dev"
  # }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  name_prefix = "${var.environment}-gke"
  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

module "network" {
  source = "../../modules/network"

  project_id  = var.project_id
  region      = var.region
  name_prefix = local.name_prefix
  enable_nat  = var.enable_private_nodes

  subnet_cidr   = var.subnet_cidr
  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr
}

module "gke" {
  source = "../../modules/gke"

  project_id           = var.project_id
  cluster_name         = "${local.name_prefix}-${var.cluster_name}"
  location             = var.location
  network_id           = module.network.network_id
  subnet_id            = module.network.subnet_id
  pods_range_name      = module.network.pods_range_name
  services_range_name  = module.network.services_range_name
  enable_private_nodes = var.enable_private_nodes
  master_cidr          = var.master_cidr
  release_channel      = var.release_channel
  authorized_networks  = var.authorized_networks
  deletion_protection  = var.deletion_protection
  labels               = local.labels
  node_pools           = var.node_pools
}
