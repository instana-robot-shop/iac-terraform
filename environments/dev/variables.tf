/**
  * Defaults
*/
variable "credentials" {
  type = map
  description = "Contains AWS Access Key and Secret Key"
}

variable "region" {
  type = list(string)
  default = ["us-east-1"]
}

variable "environment" {
  type = string
  description = "Environment Name"
  default = "dev"
}

/*****************************************
  * For infrastructure
  * Variables below are organized by services
*/
/**
  * VPC
*/

/*****************************************
  * For Kubernetes cluster
  * Variables below are organized by namespace
*/
/**
  * K8s Cluster
*/
variable "cluster_name" {
  type = string
  description = "Cluster name"
  default = "my-eks"
}

/**
  * Monitoring
*/

/**
  * Secrets Management
*/

/**
  * GitOps
*/

/**
  * Logging
*/

/**
  * Microservice Application
*/
variable "microservice_app" {
  type = list(string)
  description = "List down the names of the microservice apps to be deployed"
  default = ["cartservice", "catalogueservice", "dispatchservice", "mongodb", "mysql", "paymentservice", "ratingsservice", "shippingservice", "userservice", "web"]
}

