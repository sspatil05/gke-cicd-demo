# STAGE: production-like (private nodes, protected), but small and zonal.
project_id   = "enterprise-ci-cd-ai"
region       = "asia-south1"
location     = "asia-south1-a"
environment  = "stage"
cluster_name = "cluster"

release_channel      = "REGULAR"
enable_private_nodes = true
authorized_networks  = [] # TODO: restrict to office/VPN CIDRs before applying
deletion_protection  = true

subnet_cidr   = "10.11.0.0/20"
pods_cidr     = "10.21.0.0/16"
services_cidr = "10.31.0.0/20"
master_cidr   = "172.16.0.16/28"

node_pools = {
  workers = {
    node_count   = 2
    machine_type = "e2-standard-2"
  }
}
