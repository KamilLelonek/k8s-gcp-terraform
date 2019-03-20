# https://www.terraform.io/docs/providers/google/getting_started.html
provider "google" {
  # The project indicates the default GCP project all of your resources will be created in.
  project = "${var.project}"

  # The region will be used to choose the default location for regional resources
  region = "${var.region}"

  # The zone will be used to choose the default location for zonal resources.
  zone = "${var.zone}"

  # To prevent automatic upgrades to new major versions that may contain breaking changes
  version = "~> 2.2"
}
