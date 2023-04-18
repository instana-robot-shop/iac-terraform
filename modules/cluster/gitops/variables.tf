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
  default = "gitops"
}

/*****************************************
  * For GitOps
*/

/**
  * ArgoCD
*/
variable "argocd_admin_password" {
  default = "admin"
  description = "default grafana admin password"
  type    = string
}

