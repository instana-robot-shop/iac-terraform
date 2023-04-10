resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.14.0"
  namespace  = "logging"
  values = [
    "clusterName: my-es-cluster",
    "nodeSelector:\n  kubernetes.io/os: linux",
    "resources:\n  requests:\n    memory: 2Gi\n    cpu: 1\n  limits:\n    memory: 4Gi\n    cpu: 2",
    "volumeClaimTemplate:\n  spec:\n    accessModes: [\"ReadWriteOnce\"]\n    storageClassName: gp2\n    resources:\n      requests:\n        storage: 100Gi",
  ]
}