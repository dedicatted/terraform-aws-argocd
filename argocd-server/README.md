# ArgoCD module
## Overview
A Terraform module to deploy ArgoCD on a Kubernetes Cluster using the [Helm Provider](https://registry.terraform.io/providers/hashicorp/helm).

![Concept Flow Illustration](https://res.cloudinary.com/qunux/image/upload/v1642563762/terraform_kubernetes_argocd_mtze07.svg)
## Usage
```hcl
//Configuration to call the module
module "argocd" {
  source = "github.com/dedicatted/terraform-aws-argocd/argocd-server"
  argocd_host = "example.com"
  acm_certificate_arn = "arn:example_arn"
}
```
### Note
* To use argocd you should install ingress controller and load balancer controller. For this your can follow our eks addons repo and found [this](https://github.com/dedicatted/terraform-aws-eks-addons)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role_binding.argocd-cluster-admin-role-binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM sertificate arn with attached to ALB | `string` | n/a | yes |
| <a name="input_argocd_helm_deploy_crds"></a> [argocd\_helm\_deploy\_crds](#input\_argocd\_helm\_deploy\_crds) | Variable defining if we want to deploy argocd CRDs | `string` | `true` | no |
| <a name="input_argocd_host"></a> [argocd\_host](#input\_argocd\_host) | Hostname for ArgoCD deployment to create an additional record in Route53 | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | ArgoCD helm chart version | `string` | `"5.16.2"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AWS EKS cluster name with which terraform works | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_random_string"></a> [random\_string](#output\_random\_string) | admin password for argoccd |
