resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/prometheus-values.yaml")
  ]
}