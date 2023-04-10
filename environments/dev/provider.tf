/**
  * aws
  * used to create aws resources
*/
provider "aws" {
  region = var.region[0]
}

/**
  * k8s
  * used to connect to k8s cluster
*/
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

/**
  * helm
  * used to connect to k8s cluster
*/
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}