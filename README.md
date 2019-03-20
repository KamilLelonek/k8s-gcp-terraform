# k8s-gcp-terraform

Kubernetes on Google Cloud Platform in Google Kubernetes Engine with Terraform.

## GCP

The following setup assumes you have already a Google Profile created.

1. As the first step, go to the [Google Cloud Platform Console](https://console.cloud.google.com/) and sign in or, if you don't already have an account, sign up.
2. Then, [create a new Billing Account](https://cloud.google.com/billing/docs/how-to/manage-billing-account).
3. Finally [create a new project](https://console.cloud.google.com/projectcreate).

### CLI

To interact with the Google Cloud Platform you will use `gcloud` CLI which is a part of the Google Cloud SDK. You must download and install the SDK on your system and initialize it before you can use the gcloud command-line tool:

    brew tap caskroom/cask
    brew cask install google-cloud-sdk

Use the following command to perform several common SDK setup tasks. These include authorizing the SDK tools to access Google Cloud Platform using your user account credentials and setting up the default SDK configuration.

    gcloud init

Finally, once you've gone through the entire setup, run the initialization script to configure Google Cloud itself:

Keep in mind to fill the following variables there: `TF_BILLING_ACCOUNT_ID` and `TF_FOLDER`.

    ./init.sh

## Terraform

To use your own user credentials for Terraform when interacting with Google Cloud, run:

    gcloud auth application-default login

In your browser, log in to your Google user account when prompted and click _Allow_ to grant permission to access Google Cloud Platform resources.

Your credentials will be stored in `~/.config/gcloud/application_default_credentials.json` and used with Terraform to authorize.

### Usage

Firstly, to initialize Terraform and install all required plugins, you should do:

    terraform init -upgrade

Then, to compare the remote state with the required changes, run:

    terraform plan

Finally, to promote the local changes onto the current setup, execute:

    terraform apply
