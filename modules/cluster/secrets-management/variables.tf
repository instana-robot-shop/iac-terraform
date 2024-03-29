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
  default = "secrets-management"
}

/*****************************************
  * For Secrets Management
*/

/**
  * Hashicorp Vault
*/


