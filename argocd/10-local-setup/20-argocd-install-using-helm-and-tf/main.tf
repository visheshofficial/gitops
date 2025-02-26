provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argocd" {
  name       = "argo-cd-local"
  namespace  = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "7.8.2"

  create_namespace = true

  # values = [file("values.yaml")]
  values = [templatefile("argo-cd-values.tpl", {
    GH_CLIENT_ID     = var.KIND_GH_CLIENT_ID,
    GH_CLIENT_SECRET = var.KIND_GH_CLIENT_SECRET
    ORG_NAME         = "VB"
  })]
}

resource "helm_release" "argo_workflows" {
  name       = "argo-workflows-local"
  namespace  = "argocd"
  chart      = "argo-workflows"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "0.45.6"
  values = [templatefile("argo-workflows-values.tpl", {
    ORG_NAME = "VB"
  })]
  depends_on = [helm_release.argocd]
}

// install helm install argo-artifacts minio/minio --set service.type=LoadBalancer --set fullnameOverride=argo-artifacts

resource "helm_release" "minio" {
  name       = "argo-artifacts"
  namespace  = "argocd"
  chart      = "minio"
  repository = "https://charts.min.io/"
  version    = "5.4.0"
  set {
    name  = "resources.requests.memory"
    value = "512Mi"
  }
  set {
    name  = "replicas"
    value = "1"
  }
  set {
    name  = "persistence.enabled"
    value = "false"
  }
  set {
    name  = "mode"
    value = "standalone"
  }
  set {
    name  = "rootUser"
    value = "rootuser"
  }
  set {
    name  = "rootPassword"
    value = "rootpass123"
  }
}

variable "KIND_GH_CLIENT_ID" {}
variable "KIND_GH_CLIENT_SECRET" {}
