resource "helm_release" "metricbeat" {
  name  = "metricbeat"
  repository = "https://helm.elastic.co"
  chart = "metricbeat"
  namespace = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/metricbeat-values.yaml")
  ]

  # used to override default config values
  set {
    name  = "daemonset.enabled"
    value = var.metricbeat-daemonset-enabled
  }
  set {
    name  = "deployment.enabled"
    value = var.kubestate-enabled
  }
  set {
    name  = "kube_state_metrics.enabled"
    value = var.kubestate-enabled
  }
}