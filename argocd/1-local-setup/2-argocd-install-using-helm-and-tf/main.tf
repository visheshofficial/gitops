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
  version    = "7.7.0"

  create_namespace = true

  # values = [file("values.yaml")]
  values = [templatefile("values.tpl", {
    GH_CLIENT_ID     = var.KIND_GH_CLIENT_ID,
    GH_CLIENT_SECRET = var.KIND_GH_CLIENT_SECRET
    ORG_NAME         = "VFG-VBPS-PPE"
  })]
}

variable "KIND_GH_CLIENT_ID" {}
variable "KIND_GH_CLIENT_SECRET" {}
