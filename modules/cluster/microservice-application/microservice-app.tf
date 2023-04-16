# /**
#   * install the microservice app to eks with helm charts
# */
# resource "helm_release" "myapp" {
#   name       = "robot-shop"
#   repository = "https://instana-robot-shop.github.io/deployment-manifests/charts/"
#   chart      = "robot-shop"
#   version    = "1.0.0"
#   namespace  = "default"
# }