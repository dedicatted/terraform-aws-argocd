provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster[0].endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster[0].certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
}
provider "argocd" {
  server_addr = var.argocd_url
  username    = var.argocd_username
  password    = var.argocd_password
}
provider "github" {
  token = var.github_token
  owner = var.github_owner
}