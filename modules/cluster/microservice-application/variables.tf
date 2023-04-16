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
  default = "microservice-app"
}

/*****************************************
  * For microservice application
*/
variable "microservice_app" {
  type = list(string)
  description = "List down the names of the microservice apps to be deployed"
  default = ["cartservice", "catalogueservice", "dispatchservice", "mongodb", "mysql", "paymentservice", "ratingsservice", "shippingservice", "userservice", "web"]
}

