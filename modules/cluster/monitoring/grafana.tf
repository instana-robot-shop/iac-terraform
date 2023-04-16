resource "kubernetes_secret" "grafana-credentials" {
  metadata {
    name = "grafana-credentials"
    namespace = var.namespace
  }
  data = {
    username = var.grafana-credentials-username
    password = var.grafana-credentials-password
  }
  type = "kubernetes.io/basic-auth"

}

resource "helm_release" "grafana" {
  name  = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart = "grafana"
  namespace = var.namespace
  atomic = true
  cleanup_on_fail = true
  timeout = 100
  values = [
    file("${path.module}/configs/grafana-values.yaml")
  ]
  set {
    name  = "image.tag"
    value = var.grafana-version
  }
  set {
    name  = "image.repository"
    value = var.grafana-repository
  }
  set {
    name  = "image.replicas"
    value = var.grafana-replicas
  }
  set {
    name = "ingress.enabled"
    value = var.grafana-ingress-enabled
  }
  set {
    name = "ingress.hosts"
    value = "{${join(",", var.grafana-ingress-host)}}"
  }
  set {
    name = "persistence.enabled"
    value = var.grafana-persistence-enabled
  }
  set {
    name = "ingress.storageClassName"
    value = var.grafana-persistence-storageClassName
  }
  set {
    name = "persistence.size"
    value = var.grafana-persistence-size
  }  
  set {
    name = "plugins"
    value = var.grafana-plugins
  } 

}
