# DEV: simple, low-cost, Mumbai (asia-south1).
project_id   = "enterprise-ci-cd-ai"
region       = "asia-south1"
location     = "asia-south1-a" # zone => zonal cluster, 1 managed control plane
environment  = "dev"
cluster_name = "cluster"

release_channel      = "REGULAR"
enable_private_nodes = false
authorized_networks  = []
deletion_protection  = false

# Non-overlapping ranges per environment (allows peering/VPN later).
subnet_cidr   = "10.10.0.0/20"
pods_cidr     = "10.20.0.0/16"
services_cidr = "10.30.0.0/20"
master_cidr   = "172.16.0.0/28"

# 2 worker nodes (the control plane is managed by Google).
node_pools = {
  workers = {
    node_count   = 2
    machine_type = "e2-medium"
  }
}
