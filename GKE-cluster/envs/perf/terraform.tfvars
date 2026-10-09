# PERF: prod-shaped for realistic load tests (regional, private nodes).
# NOTE: for a regional cluster node_count is PER ZONE (3 zones => 3 nodes here).
project_id   = "enterprise-ci-cd-ai"
region       = "asia-south1"
location     = "asia-south1" # region => regional cluster, HA control plane
environment  = "perf"
cluster_name = "cluster"

release_channel      = "REGULAR"
enable_private_nodes = true
authorized_networks  = []    # TODO: restrict to office/VPN/load-generator CIDRs before applying
deletion_protection  = false # perf is rebuilt often

subnet_cidr   = "10.12.0.0/20"
pods_cidr     = "10.22.0.0/16"
services_cidr = "10.32.0.0/20"
master_cidr   = "172.16.0.32/28"

node_pools = {
  workers = {
    node_count   = 1
    machine_type = "e2-standard-4"
  }
}
