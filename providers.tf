# Backend Configuration
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.15.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
  }
}

# Kubernetes Provider
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-kind" 
}

# Helm provider
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}