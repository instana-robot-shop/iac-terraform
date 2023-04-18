resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace  = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/hc-vault-values.yaml")
  ]

  # used to override default config values
  set {
    name  = "server.dev.enabled"
    value = "true"
  }
  set {
    name  = "server.dev.listener"
    value = "tcp://0.0.0.0:8200"
  }
}