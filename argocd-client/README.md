# ArgoCD client
## Overview
Terraform module which register destination cluster in ArgoCD and create project, application and application for application in your ArgoCD cluster.

## Usage
```hcl
//Configuration to call the module
module "argocd" {
  source               = "github.com/dedicatted/terraform-aws-argocd"
  create               = true
  cluster_name         = "name of your destination cluster which you try to add"
  argocd_url           = "example.com"
  argocd_repo_url      = "github.com/dedicatted/terraform-aws-argocd"
  project_cluster_list = ["https://kubernetes.default.svc", "your_second_cluster"]
  argocd_repo_name     = "terraform-aws-argocd"
  argocd_password      = "password"
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_argocd"></a> [argocd](#requirement\_argocd) | 5.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_argocd"></a> [argocd](#provider\_argocd) | 5.6.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [argocd_application.application](https://registry.terraform.io/providers/oboukili/argocd/5.6.0/docs/resources/application) | resource |
| [argocd_application.appofapp](https://registry.terraform.io/providers/oboukili/argocd/5.6.0/docs/resources/application) | resource |
| [argocd_cluster.kubernetes](https://registry.terraform.io/providers/oboukili/argocd/5.6.0/docs/resources/cluster) | resource |
| [argocd_project.argocd_project](https://registry.terraform.io/providers/oboukili/argocd/5.6.0/docs/resources/project) | resource |
| [github_repository_file.application](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.file](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [kubernetes_cluster_role_binding_v1.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_secret_v1.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [kubernetes_service_account_v1.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [kubernetes_secret_v1.argocd_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_of_app_destination_cluster"></a> [app\_of\_app\_destination\_cluster](#input\_app\_of\_app\_destination\_cluster) | Cluster endpoint for applicaition of application approach where it sould be deployed | `string` | `"https://kubernetes.default.svc"` | no |
| <a name="input_app_of_app_destination_namespace"></a> [app\_of\_app\_destination\_namespace](#input\_app\_of\_app\_destination\_namespace) | Namespace for application of application approach | `string` | `"default"` | no |
| <a name="input_application_cluster_endpoint"></a> [application\_cluster\_endpoint](#input\_application\_cluster\_endpoint) | Cluster endpoint for applicaition where it sould be deployed | `string` | `"https://kubernetes.default.svc"` | no |
| <a name="input_application_namespace"></a> [application\_namespace](#input\_application\_namespace) | Namespace for application approach | `string` | `"default"` | no |
| <a name="input_argocd_password"></a> [argocd\_password](#input\_argocd\_password) | Password which used buy argo cd terraform provider to login to argocd | `string` | n/a | yes |
| <a name="input_argocd_repo_name"></a> [argocd\_repo\_name](#input\_argocd\_repo\_name) | Name of github repo for GitOps approach | `string` | n/a | yes |
| <a name="input_argocd_repo_url"></a> [argocd\_repo\_url](#input\_argocd\_repo\_url) | Repository url for GitOps approach | `string` | n/a | yes |
| <a name="input_argocd_resource_name"></a> [argocd\_resource\_name](#input\_argocd\_resource\_name) | Name of ArgoCD custom resource | `string` | `"terraform-managed"` | no |
| <a name="input_argocd_url"></a> [argocd\_url](#input\_argocd\_url) | Argo CD url | `string` | n/a | yes |
| <a name="input_argocd_username"></a> [argocd\_username](#input\_argocd\_username) | Username which used buy argo cd terraform provider to login to argocd | `string` | `"admin"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of cluster which you add to argocd | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Variable indicating whether deployment is enabled. | `bool` | `false` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Github token for access to git hub repository | `string` | n/a | yes |
| <a name="input_project_cluster_list"></a> [project\_cluster\_list](#input\_project\_cluster\_list) | List of cluster which available in new created project | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region where deployed eks cluster | `bool` | `"us-east-1"` | no |

## Outputs

No outputs.
