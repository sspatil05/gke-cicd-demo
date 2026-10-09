variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "location" {
  type        = string
  description = "Zone for a zonal cluster, or region for a regional one."
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "enable_private_nodes" {
  type    = bool
  default = false
}

variable "release_channel" {
  type    = string
  default = "REGULAR"
}

variable "subnet_cidr" {
  type = string
}

variable "pods_cidr" {
  type = string
}

variable "services_cidr" {
  type = string
}

variable "master_cidr" {
  type        = string
  description = "/28 for the control plane; used only when enable_private_nodes = true."
}

variable "authorized_networks" {
  type = list(object({
    cidr = string
    name = string
  }))
  default = []
}

variable "deletion_protection" {
  type    = bool
  default = true
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
