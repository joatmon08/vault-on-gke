# Vault on GKE

This sets up a publicly available Vault on GKE using state storage for Terraform
Cloud.

## Prerequisites

1. Fork this repository.

1. Download and install [Terraform][terraform] 0.12+.

1. Sign up for Terraform Cloud. [Create an
   organization](https://www.terraform.io/docs/cloud/getting-started/access.html)
   and [log in from the Terraform
   CLI](https://www.terraform.io/docs/commands/login.html).

1. In Terraform Cloud, [set up a VCS
   Provider](https://www.terraform.io/docs/cloud/vcs/gitlab-com.html) connected
   to GitHub.

1. Under the organization, create [a workspace with a VCS
   connection](https://www.terraform.io/docs/cloud/workspaces/creating.html).

## Instructions

1. Add variables to Terraform Cloud's workspace.

   * `project`: GCP Project with Kubernetes cluster
   * `region`: Region to deploy bucket, etc.
   * `kubernetes_cluster`: Name of the Kubernetes cluster in GCP
   * `kubernetes_cluster_location`: Location of the Kubernetes cluster in GCP
   * `namespace`: namespace to deploy the Vault instance

1. Add environment variables to Terraform Cloud's workspace.

   * `GOOGLE_CREDENTIALS`: Mark as sensitive. This is the GCP service account
     credentials in JSON format.
   * `CONFIRM_DESTROY`: Set to `1`. This allows GitLab to trigger Terrraform
     destroy.

1. Create the VCS connection in Terraform Cloud. This operation defers execution to the Terraform Cloud
   workspace. The Terraform module:

    * Creates a bucket for storage
    * Creates a KMS key for encryption
    * Creates a service account with the most restrictive permissions to those
       resources
    * Creates a public IP
    * Deploys the Vault Helm chart in HA configuration, with GCS storage backend
       and autounseal with GCP KMS.


## Interact with Vault

1. Log into the Kubernetes cluster using `gcloud container clusters get-credentials`.

1. Run the following script to initialize Vault, retrieve the root token,
   and obtain the Vault address.

   ```shell
   > KUBE_NAMESPACE=<vault namespace> bash vault-init.sh
   ```

1. Export environment variables:

    Vault reads these environment variables for communication. Set Vault's
    address and the initial root token.

    ```shell
    > export VAULT_ADDR="http://<vault IP>:8200"
    > export VAULT_TOKEN="<root token>"
    ```

1. Run some commands:

    ```shell
    > vault secrets enable -path=secret -version=2 kv
    > vault kv put secret/foo a=b
    ```

## Cleaning Up

There is a final step in the pipeline that destroys the Terraform resources.
