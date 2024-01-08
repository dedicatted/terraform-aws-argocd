module "argocd" {
  source               = "github.com/dedicatted/terraform-aws-argocd/argocd-client"
  create               = true
  cluster_name         = "name of your destination cluster which you try to add"
  argocd_url           = "example.com"
  argocd_repo_url      = "github.com/dedicatted/terraform-aws-argocd"
  project_cluster_list = ["https://kubernetes.default.svc", "your_second_cluster"]
  argocd_repo_name     = "terraform-aws-argocd"
  argocd_password      = "password"
}