resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/grafana-values.yaml")
  ]
}


