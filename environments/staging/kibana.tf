resource "helm_release" "kibana" {
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "7.14.0"
  namespace  = "logging"
  values = [
    "image:\n  tag: 7.14.0",
    "nodeSelector:\n  kubernetes.io/os: linux",
    "ingress:\n  enabled: true\n  annotations:\n    nginx.ingress.kubernetes.io/rewrite-target: /$2\n  hosts:\n    - host: kibana.example.com\n      paths:\n        - /kibana(/|$)(.*)",
    "elasticsearchHosts: http://elasticsearch-master.logging.svc.cluster.local:9200",
  ]
}