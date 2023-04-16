/*****************************************
  * For infrastructure
  * Not needed for dev environment except for a few (e.g. ECR)
*/
# module "infrastructure" {
#   source = "../../modules/infrastructure"
# }

/*****************************************
  * For Kubernetes cluster
*/
resource "kubernetes_namespace" "gitops" {
  metadata {
    name = "gitops"
  }
}
resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}
resource "kubernetes_namespace" "microservice-application" {
  metadata {
    name = "microservice-app"
  }
}
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
resource "kubernetes_namespace" "secrets-management" {
  metadata {
    name = "secrets-management"
  }
}

module "gitops" {
  source = "../../modules/cluster/gitops"

  environment = "dev"
  namespace = "gitops"
}
module "logging" {
  source = "../../modules/cluster/logging"

  environment = "dev"
  namespace = "logging"
}
module "microservice-application" {
  source = "../../modules/cluster/microservice-application"

  environment = "dev"
  namespace = "microservice-app"
}
module "monitoring" {
  source = "../../modules/cluster/monitoring"

  environment = "dev"
  namespace = "monitoring"
}
module "secrets-management" {
  source = "../../modules/cluster/secrets-management"

  environment = "dev"
  namespace = "secrets-management"
}
