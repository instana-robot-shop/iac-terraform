/*****************************************
  * Defaults
*/
variable "environment" {
  type = string
  description = "Environment Name"
  default = "dev"
}

/*****************************************
  * For infrastructure
  * Variables below are organized by services
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
  * ECR
*/

/**
  * EKS
*/

/**
  * IAM
*/

/**
  * VPC
*/

