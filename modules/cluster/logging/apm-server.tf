resource "helm_release" "apm-server" {
  #   depends_on = [helm_release.elasticsearch,helm_release.kibana]
  name  = "apm-server"
  repository = "https://helm.elastic.co"
  chart = "apm-server"
  namespace = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/apm-server-values.yaml")
  ]
}