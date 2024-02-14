variable "create" {
  description = "Variable indicating whether deployment is enabled."
  default     = false
  type        = bool
}
variable "cluster_name" {
  description = "Name of cluster which you add to argocd"
  type        = string
}
variable "region" {
  description = "AWS Region where deployed eks cluster"
  default     = "us-east-1"
  type        = bool
}
variable "argocd_url" {
  description = "Argo CD url"
  type        = string
}
variable "argocd_resource_name" {
  description = "Name of ArgoCD custom resource"
  default     = "terraform-managed"
}
variable "argocd_repo_url" {
  description = "Repository url for GitOps approach"
  type        = string
}
variable "application_cluster_endpoint" {
  description = "Cluster endpoint for applicaition where it sould be deployed"
  type        = string
  default     = "https://kubernetes.default.svc"
}
variable "project_cluster_list" {
  description = "List of cluster which available in new created project"
  type        = list(string)
}
variable "argocd_repo_name" {
  description = "Name of github repo for GitOps approach"
  type        = string
}
variable "app_of_app_destination_cluster" {
  description = "Cluster endpoint for applicaition of application approach where it sould be deployed"
  type        = string
  default     = "https://kubernetes.default.svc"
}
variable "app_of_app_destination_namespace" {
  description = "Namespace for application of application approach"
  type        = string
  default     = "default"
}
variable "application_namespace" {
  description = "Namespace for application approach"
  type        = string
  default     = "default"
}
variable "github_token" {
  description = "Github token for access to git hub repository"
  type        = string
}
variable "argocd_username" {
  description = "Username which used buy argo cd terraform provider to login to argocd"
  default     = "admin"
  type        = string
}

variable "argocd_password" {
  description = "Password which used buy argo cd terraform provider to login to argocd"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner used to configure the provider"
  type        = string
  default     = ""
}
