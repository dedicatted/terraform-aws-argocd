terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    argocd = {
      source  = "oboukili/argocd"
      version = "5.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
