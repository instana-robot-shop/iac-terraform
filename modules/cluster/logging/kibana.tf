resource "helm_release" "kibana" {
#   depends_on = [helm_release.elasticsearch]
  name  = "kibana"
  repository = "https://helm.elastic.co"
  chart = "kibana"
  namespace = var.namespace
  atomic = true
  cleanup_on_fail = true
  values = [
    file("${path.module}/configs/kibana-values.yaml")
  ]
  set {
    name  = "imageTag"
    value = var.kibana-version
  }
  set {
    name  = "replicas"
    value = var.kibana-replicas
  }
  set {
    name = "ingress.enabled"
    value = var.kibana-ingress-enabled
  }
  set {
    name = "ingress.hosts[0].host"
    value = var.kibana-ingress-host
  }
  set {
    name = "ingress.hosts[0].paths[0].path"
    value = "/"
  }

}