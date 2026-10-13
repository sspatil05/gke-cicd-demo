variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "registry_name" {
  type = string
}

variable "github_repository" {
  type        = string
  description = "owner/repo allowed to deploy, e.g. sspatil05/gke-cicd-demo"
}

variable "wif_pool_id" {
  type        = string
  description = "Workload Identity pool ID. Deleted pool IDs are reserved for 30 days, so change it when rebuilding soon after a destroy."
}
