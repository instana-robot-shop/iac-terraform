resource "helm_release" "apm-server" {
  #   depends_on = [helm_release.elasticsearch,helm_release.kibana]
  name  = "apm-server"
  repository = "https://helm.elastic.co"
  chart = "apm-server"
  namespace = var.namespace
  atomic = true
  cleanup_on_fail = true
  values = [
    file("${path.module}/configs/apm-server-values.yaml")
  ]
  set {
    name  = "imageTag"
    value = var.apm-server-version
  }
}