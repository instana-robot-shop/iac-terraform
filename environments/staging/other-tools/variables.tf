/**
  * credentials
*/
variable "credentials" {
  type = map
  description = "contains aws access key and secret key"
}

variable "region" {
  type = list(string)
  default = ["us-east-1"]
}

/**
  * eks 
*/
variable "cluster_name" {
  type = string
  description = "eks cluster name"
  default = "my-eks"
}

/**
  * others 
*/
variable "environment" {
  type = string
  description = "environment name"
  default = "staging"
}