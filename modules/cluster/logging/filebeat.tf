resource "helm_release" "filebeat" {
  name  = "filebeat"
  repository = "https://helm.elastic.co"
  chart = "filebeat"
  namespace = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/filebeat-values.yaml")
  ]

  # used to override default config values
  set {
    name  = "daemonset.enabled"
    value = var.filebeat-daemonset-enabled
  }
  set {
    name  = "deployment.enabled"
    value = var.filebeat-deployment-enabled
  }
}

