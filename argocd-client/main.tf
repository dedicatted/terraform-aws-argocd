data "aws_eks_cluster" "cluster" {
  count = var.create ? 1 : 0
  name  = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  count = var.create ? 1 : 0
  name  = var.cluster_name
}

resource "kubernetes_secret_v1" "argocd_manager" {
  count = var.create ? 1 : 0
  metadata {

    name      = "argocd-manager-token"
    namespace = "kube-system"
    annotations = {
      "kubernetes.io/service-account.name" = "argocd-manager"
    }
  }
  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_service_account_v1" "argocd_manager" {
  count = var.create ? 1 : 0

  metadata {
    name      = "argocd-manager"
    namespace = "kube-system"
  }
  secret {
    name = "argocd-manager-token"
    # cannot set to this value without receiving 'secrets "argocd-manager-token-77cq8" not found'
    # name = kubernetes_secret.argocd_manager.metadata[0].name
  }

}

resource "kubernetes_cluster_role_v1" "argocd_manager" {
  count = var.create ? 1 : 0

  metadata {
    name = "argocd-manager-role"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "argocd_manager" {
  count = var.create ? 1 : 0

  metadata {
    name = "argocd-manager-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.argocd_manager[0].metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.argocd_manager[0].metadata.0.name
    namespace = kubernetes_service_account_v1.argocd_manager[0].metadata.0.namespace
  }
}

data "kubernetes_secret_v1" "argocd_manager" {
  count = var.create ? 1 : 0

  metadata {
    name      = kubernetes_service_account_v1.argocd_manager[0].metadata.0.name
    namespace = kubernetes_service_account_v1.argocd_manager[0].metadata.0.namespace
  }
}


resource "argocd_cluster" "kubernetes" {
  count = var.create ? 1 : 0

  name   = var.cluster_name
  server = format("https://%s", data.aws_eks_cluster.cluster[0].endpoint)
  config {
    bearer_token = kubernetes_secret_v1.argocd_manager[0].data.token

    tls_client_config {
      ca_data = base64decode(data.aws_eks_cluster.cluster[0].certificate_authority[0].data)
    }

  }
  lifecycle {
    ignore_changes = [metadata[0].labels, metadata[0].annotations]
  }
}
resource "github_repository_file" "file" {
  repository          = var.argocd_repo_name
  branch              = "main"
  file                = "${var.argocd_resource_name}/README.md"
  content             = "This folder contain all the needed configuration files for ArgoCD to deploy ${var.argocd_resource_name} applications"
  commit_message      = "Managed by Terraform"
  overwrite_on_create = true
}
resource "github_repository_file" "application" {
  repository          = var.argocd_repo_name
  branch              = "main"
  file                = "${var.argocd_resource_name}-application/README.md"
  content             = "This folder contain all the needed configuration files for ArgoCD to deploy ${var.argocd_resource_name} applications"
  commit_message      = "Managed by Terraform"
  overwrite_on_create = true
}

resource "argocd_project" "argocd_project" {
  depends_on = [argocd_cluster.kubernetes]
  lifecycle {
    create_before_destroy = true
  }
  metadata {
    name      = var.argocd_resource_name
    namespace = "argocd"
    labels = {
      acceptance = "true"
    }
  }
  spec {
    description = "${var.argocd_resource_name} project"

    source_namespaces = ["*"]
    source_repos      = ["*"]

    dynamic "destination" {
      for_each = var.project_cluster_list
      content {
        server    = destination.value
        namespace = "*"
      }
    }

    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }
  }
}
resource "argocd_application" "application" {
  depends_on = [argocd_project.argocd_project]
  metadata {
    name      = var.argocd_resource_name
    namespace = "argocd"
  }

  spec {
    project = var.argocd_resource_name
    source {
      repo_url        = var.argocd_repo_url
      target_revision = "HEAD"
      ref             = "main"
      path            = var.argocd_resource_name
    }

    destination {
      server    = var.application_cluster_endpoint
      namespace = var.application_namespace
    }
    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      # Only available from ArgoCD 1.5.0 onwards
      sync_options = ["Validate=false", "CreateNamespace=true"]
      retry {
        limit = "5"
        backoff {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [spec[0].source]
  }
}

resource "argocd_application" "appofapp" {
  depends_on = [argocd_project.argocd_project]
  metadata {
    name      = "${var.argocd_resource_name}-applications"
    namespace = var.app_of_app_destination_namespace
  }

  spec {
    project = var.argocd_resource_name

    source {
      repo_url        = var.argocd_repo_url
      target_revision = "HEAD"
      ref             = "main"
      path            = "${var.argocd_resource_name}-application"
    }

    destination {
      server    = var.app_of_app_destination_cluster
      namespace = var.app_of_app_destination_namespace
    }
    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      # Only available from ArgoCD 1.5.0 onwards
      sync_options = ["Validate=false", "CreateNamespace=true"]
      retry {
        limit = "5"
        backoff {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [spec[0].source]
  }
}
