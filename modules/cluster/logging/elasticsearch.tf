resource "kubernetes_secret" "elasticsearch-credentials" {
  metadata {
    name = "elasticsearch-credentials"
    namespace = var.namespace
  }
  data = {
    username = var.elasticsearch-credentials-username
    password = var.elasticsearch-credentials-username
  }
  type = "kubernetes.io/basic-auth"
}

resource "helm_release" "elasticsearch" {
  name  = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart = "elasticsearch"
  namespace = var.namespace
  atomic = true
  cleanup_on_fail = true
  values = [
    file("${path.module}/configs/elasticsearch-values.yaml")
  ]
  set {
    name  = "imageTag"
    value = var.elasticsearch-version
  }
  set {
    name = "ingress.enabled"
    value = var.elasticsearch-ingress-enabled
  }
  set {
    name = "ingress.hosts[0].host"
    value = var.elasticsearch-ingress-host
  }
  set {
    name = "ingress.hosts[0].paths[0].path"
    value = "/"
  }
  set {
    name = "esJavaOpts"
    value = var.elasticsearch-esJavaOpts
  }
  set {
    name = "volumeClaimTemplate.resources.requests.storage"
    value = var.elasticsearch-persistence-size
  }

}
