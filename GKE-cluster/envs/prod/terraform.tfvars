# PROD: regional (HA control plane), private nodes, deletion-protected.
# NOTE: for a regional cluster node_count is PER ZONE (3 zones x 2 = 6 nodes).
project_id   = "enterprise-ci-cd-ai" # TODO: use a dedicated prod project
region       = "asia-south1"
location     = "asia-south1" # region => regional cluster
environment  = "prod"
cluster_name = "cluster"

release_channel      = "STABLE"
enable_private_nodes = true
authorized_networks  = [] # TODO: REQUIRED - restrict to office/VPN CIDRs before applying
deletion_protection  = true

subnet_cidr   = "10.13.0.0/20"
pods_cidr     = "10.23.0.0/16"
services_cidr = "10.33.0.0/20"
master_cidr   = "172.16.0.48/28"

node_pools = {
  workers = {
    node_count   = 2
    machine_type = "e2-standard-4"
  }
}
