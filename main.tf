# Enable Kubernetes Engine API for the project.
resource "google_project_service" "kubernetes" {
  project = "${var.project}"
  service = "container.googleapis.com"
}

# Manages a Google Kubernetes Engine (GKE) cluster.
resource "google_container_cluster" "kubernetes" {
  name = "${var.cluster}"

  # Waits for Kubernetes Engine API to be enabled
  depends_on = ["google_project_service.kubernetes"]

  # Must be set if `node_pool` is not set.
  initial_node_count = 1

  # Disable basic auth
  master_auth {
    username = ""
    password = ""
  }

  # Parameters used in creating the cluster's nodes.
  node_config {
    # The following scopes are necessary to ensure the correct functioning of the cluster.
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    # Tags are used to identify valid sources or targets for network firewalls.
    tags = ["network-cluster"]
  }
}

# Fetches the project name, and provides the appropriate URLs to use for container registry.
data "google_container_registry_repository" "kubernetes" {
  # The GCR region to use.
  region = "eu"
}
