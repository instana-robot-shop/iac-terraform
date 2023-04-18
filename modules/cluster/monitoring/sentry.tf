resource "helm_release" "sentry" {
  name       = "sentry"
  repository = "https://sentry-kubernetes.github.io/charts"
  chart      = "sentry"
  namespace  = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/sentry-values.yaml")
  ]

  # used to override default config values
  set {
    name  = "postgresql.postgresqlPassword"
    value = var.sentry_postgresql_password
  }
}