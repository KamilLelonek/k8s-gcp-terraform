#!/usr/bin/env bash

export TF_PROJECT_NAME="k8s-elixir-project"
export TF_REGION="europe-west3"
export TF_CLUSTER="elixir-cluster"
export TF_BILLING_ACCOUNT_ID=
export TF_FOLDER=

# Create new Admin Project
gcloud projects create ${TF_PROJECT_NAME} \
  --folder ${TF_FOLDER} \
  --set-as-default

# Link Billing Account
gcloud beta billing projects link ${TF_PROJECT_NAME} \
  --billing-account ${TF_BILLING_ACCOUNT_ID}

# Create `variables.tf` variables file
cat > gcp/variables.tf <<-EOF
variable "project" {
  default = "${TF_PROJECT_NAME}"
}

variable "region" {
  default = "${TF_REGION}"
}

variable "zone" {
  default = "${TF_REGION}-a"
}

variable "cluster" {
  default = "${TF_CLUSTER}"
}
EOF

# Create Remote Bucket to keep `terraform.tfstate` shareable and in sync
gsutil mb \
    -p ${TF_PROJECT_NAME} \
    -l ${TF_REGION} \
    gs://${TF_PROJECT_NAME}

# Create `backend.tf` configuration file
cat > gcp/backend.tf <<-EOF
terraform {
  # Which versions of the Terraform CLI can be used with the configuration
  required_version = "~> 0.11"

  # Store Terraform state and the history of all revisions remotely, and protect that state with locks to prevent corruption.
  backend "gcs" {
    # The name of the Google Cloud Storage (GCS) bucket
    bucket  = "${TF_PROJECT_NAME}"
    project = "${TF_PROJECT_NAME}"
    region  = "${TF_REGION}"
  }
}
EOF

# Enable versioning for the Remote Bucket
gsutil versioning set on gs://${TF_PROJECT_NAME}
