resource "helm_release" "elasticsearch" {
  name  = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart = "elasticsearch"
  namespace = var.namespace
  
  # default config values for the chart - these values are found from the artifacthub page of the chart
  values = [
    file("${path.module}/configs/elasticsearch-values.yaml")
  ]
  
  # used to override default config values
  set {
    name = "replicas"
    value = "1"
  }
  set {
    name =  "esJavaOpts"
    value = "-Xmx512m -Xms512m"
  }
}
