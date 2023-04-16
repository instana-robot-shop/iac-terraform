/*****************************************
  * Defaults
*/
variable "environment" {
  type = string
  description = "Environment Name"
  default = "dev"
}
variable "cluster_name" {
  type = string
  description = "Cluster name"
  default = "my-eks"
}
variable "namespace" {
  type = string
  description = "Namespace"
  default = "kube-system"
}

/*****************************************
  * For Add-ons
*/

/**
  * Karpenter
*/

/**
  * AWS Load Balancer Controller
*/

