variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Zone (zonal cluster, cheaper) or region (regional cluster, HA control plane)."
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "pods_range_name" {
  type = string
}

variable "services_range_name" {
  type = string
}

variable "release_channel" {
  type    = string
  default = "REGULAR"
}

variable "enable_private_nodes" {
  type    = bool
  default = false
}

variable "master_cidr" {
  type    = string
  default = "172.16.0.0/28"
}

variable "authorized_networks" {
  type = list(object({
    cidr = string
    name = string
  }))
  default     = []
  description = "CIDRs allowed to reach the API server. Empty = no restriction."
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "node_pools" {
  type = map(object({
    node_count   = number
    machine_type = string
    disk_size_gb = optional(number, 50)
    disk_type    = optional(string, "pd-standard")
    spot         = optional(bool, false)
  }))
}
