output "client_certificate" {
  description = "Public certificate used by clients to authenticate to the cluster endpoint."
  value       = "${base64decode(google_container_cluster.kubernetes.master_auth.0.client_certificate)}"
}

output "client_key" {
  description = "Private key used by clients to authenticate to the cluster endpoint."
  value       = "${base64decode(google_container_cluster.kubernetes.master_auth.0.client_key)}"
}

output "cluster_ca_certificate" {
  description = "Public certificate that is the root of trust for the cluster."
  value       = "${base64decode(google_container_cluster.kubernetes.master_auth.0.cluster_ca_certificate)}"
}

output "endpoint" {
  description = "The IP address of this cluster's Kubernetes master."
  value       = "${google_container_cluster.kubernetes.endpoint}"
}

output "gcr_location" {
  description = "URL to use for the container registry."
  value       = "${data.google_container_registry_repository.kubernetes.repository_url}"
}
