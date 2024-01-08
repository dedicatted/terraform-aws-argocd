module "argocd" {
  source              = "github.com/dedicatted/terraform-aws-argocd/argocd-server"
  argocd_host         = "example.com"
  acm_certificate_arn = "arn:example_arn"
}