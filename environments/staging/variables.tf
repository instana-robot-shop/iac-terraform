/**
  * Credentials
*/
variable "credentials" {
  type = map
  description = "Contains AWS Access Key and Secret Key"
}

variable "region" {
  type = list(string)
  default = ["us-east-1"]
}

/**
  * EKS 
*/
variable "cluster_name" {
  type = string
  description = "EKS cluster name"
  default = "my-eks"
}

/**
  * Jenkins
*/
variable "jenkins_admin_user" {
  type        = string
  description = "Admin user of the Jenkins Application."
  default     = "admin"
}

variable "jenkins_admin_password" {
  type        = string
  description = "Admin password of the Jenkins Application."
}

/**
  * Others 
*/
variable "environment" {
  type = string
  description = "Environment Name"
  default = "staging"
}

variable "microservice_apps" {
  type = list(string)
  description = "List down the names of the microservice apps to be deployed"
  default = ["cloud-config-server", "cloud-gateway", "department-service", "hystric-dashboard", "service-registry", "user-service"]
}