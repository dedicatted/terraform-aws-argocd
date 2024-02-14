variable "chart_version" {
  default     = "5.16.2"
  description = "ArgoCD helm chart version"
  type        = string
}
variable "argocd_helm_deploy_crds" {
  description = "Variable defining if we want to deploy argocd CRDs"
  default     = true
  type        = string
}
variable "argocd_host" {
  description = "Hostname for ArgoCD deployment to create an additional record in Route53"
  type        = string
}
variable "cluster_name" {
  description = "AWS EKS cluster name with which terraform works"
  type        = string
}
variable "acm_certificate_arn" {
  description = "ACM sertificate arn with attached to ALB"
  type        = string
}
