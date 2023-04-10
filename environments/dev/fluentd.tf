resource "helm_release" "fluentd" {
  name       = "fluentd"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "fluentd"
  version    = "1.14.0"
  namespace  = "logging"
  values = [
    "image:\n  repository: bitnami/fluentd",
    "imageTag: 1.14.0-debian-10-r25",
    "resources:\n  requests:\n    memory: 256Mi\n    cpu: 100m\n  limits:\n    memory: 512Mi\n    cpu: 200m",
    "elasticsearchHost: elasticsearch-master.logging.svc.cluster.local",
    "elasticsearchPort: 9200",
  ]
}