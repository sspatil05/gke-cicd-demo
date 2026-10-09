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
