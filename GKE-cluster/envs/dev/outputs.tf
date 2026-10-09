output "cluster_name" {
  value = module.gke.cluster_name
}

output "get_credentials_command" {
  value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --location ${var.location} --project ${var.project_id}"
}
