# resource "helm_release" "kibana" {
#   name  = "kibana"
#   repository = "https://helm.elastic.co"
#   chart = "kibana"
#   namespace = var.namespace

#   # default config values for the chart - these values are found from the artifacthub page of the chart
#   values = [
#     file("${path.module}/configs/kibana-values.yaml")
#   ]

#   # used to override default config values
#   set {
#     name  = "service.type"
#     value = "NodePort"
#   }

#   set {
#     name  = "ingress.enabled"
#     value = "true"
#   }

#   set {
#     name  = "ingress.hosts[0].host"
#     value = "kibana.local"
#   }

#   set {
#     name  = "ingress.hosts[0].paths[0]"
#     value = "/"
#   }

# }