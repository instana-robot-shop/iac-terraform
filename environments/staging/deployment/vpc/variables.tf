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
  * others 
*/
variable "environment" {
  type = string
  description = "environment name"
  default = "staging"
}