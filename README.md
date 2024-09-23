## Atlantis Deployment with Terraform, Helm, and ngrok

This project provides a Terraform configuration to deploy Atlantis into a Kubernetes cluster using Helm. 
Atlantis is securely exposed to the internet using ngrok for GitHub integration.

Features:
Deploy Atlantis in a Kubernetes namespace.
Integrate with GitHub for managing Terraform pull requests.
Expose Atlantis to the internet using ngrok for secure external access.
Configure GitHub authentication and organization allowlist.

### Prerequisites

Before deploying Atlantis, ensure you meet the following prerequisites:

Kubernetes Cluster: You must have a Kubernetes cluster (either local or cloud-based) ready.
Kubeconfig: Ensure you have a valid kubeconfig for your cluster.
Helm: Install Helm for managing Kubernetes charts.
Terraform: Ensure Terraform is installed (version 0.12 or higher).
GitHub Authentication: You need GitHub credentials (token, user, and secret) to integrate Atlantis with your GitHub repositories.
ngrok: Install ngrok to securely expose Atlantis to the internet.

### Required Tools:
Terraform
Helm
kubectl
GitHub Account
ngrok
Configuration

### Input Variables
github_user: Your GitHub username.
github_token: GitHub token with the necessary permissions to access repositories and create PRs.
github_secret: GitHub secret used to validate the webhook signature.
atlantis_repo_url: The URL of the Atlantis instance. (Use ngrok URL if exposing with ngrok)

### Example terraform.tfvars:

```hcl
github_user       = "your-github-username"
github_token      = "your-github-token"
github_secret     = "your-github-webhook-secret"
atlantis_repo_url = "http://your-ngrok-url.ngrok.io" # ngrok URL
```

### Usage

1. Clone the Repository

```bash
git clone https://github.com/oluwafemiayo/atlantis
cd atlantis
```

2. Initialize Terraform
Run the following command to initialize Terraform and download the necessary providers:

```bash
terraform init
```

3. Review and Apply the Terraform Configuration
Review the Terraform plan to ensure it meets your needs:

```bash
terraform plan
```

Apply the configuration to deploy Atlantis:

```bash
terraform apply
```

4. Exposing Atlantis Using ngrok
After Atlantis is deployed in your Kubernetes cluster, use ngrok to expose it to the internet, allowing GitHub to send webhook events to Atlantis.

Steps to Set Up ngrok:

Install ngrok if you haven't already. You can download it from ngrok's official site.
Run the following command to expose Atlantis on port 80 (replace 80 with your Atlantis service port if it's different):
bash
```bash
ngrok http 4141
ngrok will provide you with a public URL that looks like https://651c-2a00-7a03.ngrok-free.app.
Use this ngrok URL for your atlantis_repo_url when configuring Atlantis in Terraform or GitHub.

Example terraform.tfvars:

```hcl
atlantis_repo_url = "https://651c-2a00-7a03.ngrok-free.app"
```

Update your GitHub webhooks with the ngrok URL to allow GitHub to send events to Atlantis.
5. Accessing Atlantis
Payload URL: https://651c-2a00-7a03.ngrok-free.app/events 
Content Type: application/json
secret <your_github_secret>(same webhook secret used in configuring atlantis)
select -indiviudal event , pushes, pull requests, issue comment, & pull request comment-


```bash
kubectl get svc -n atlantis
kubectl port-forward svc/atlantis 4141:80 -n atlantis
```

GitHub Integration: Ensure that your GitHub credentials (user, token, secret) are set correctly in your configuration, and the allowlist is updated.
ngrok URL: Ensure the atlantisUrl is set to the ngrok URL for external access.


### Test
Create a pull request in github repository to test atlantis integration.
Update configuration and webhook intergration everytime ngrok restarts as url changes

To remove the Atlantis deployment, run the following command:

```bash
terraform destroy
```
