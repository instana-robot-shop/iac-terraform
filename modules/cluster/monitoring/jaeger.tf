resource "helm_release" "jaeger" {
  name       = "jaeger"
  repository = "https://jaegertracing.github.io/helm-charts"
  chart      = "jaeger"
  namespace  = var.namespace

  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/jaeger-values.yaml")
  ]

  # used to override default config values
  set {
    name  = "ingester.traces.sampling.strategies.default.probabilistic.sampling.rate"
    value = "0.1"
  }
}