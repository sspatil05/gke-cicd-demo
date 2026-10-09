output "GCP_WIF_PROVIDER" {
  description = "Value for the GitHub repo secret GCP_WIF_PROVIDER"
  value       = google_iam_workload_identity_pool_provider.github.name
}

output "GCP_SERVICE_ACCOUNT" {
  description = "Value for the GitHub repo secret GCP_SERVICE_ACCOUNT"
  value       = google_service_account.deployer.email
}

output "image_repository" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.apps.repository_id}"
}
