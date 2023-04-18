resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.namespace

  values = [
    file("${path.module}/configs/argocd-values.yaml")
  ]

  set {
    name  = "server.global.deployment.adminPassword"
    value = var.argocd_admin_password
  }
}