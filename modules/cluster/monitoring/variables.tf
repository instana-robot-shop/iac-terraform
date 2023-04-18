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
  default = "monitoring"
}

/*****************************************
  * For Monitoring
*/

/**
  * Grafana
*/
variable "grafana-credentials-username" {
    default = "admin"
    description = "default grafana username"
    type    = string
}
variable "grafana-credentials-password" {
    default = "admin"
    description = "default grafana password"
    type    = string
}
variable "grafana-repository" {
    default = "grafana/grafana"
    description = "grafana repository"
    type    = string
}
variable "grafana-version" {
    default = "8.0.0"
    description = "grafana version"
    type    = string
}
variable "grafana-replicas" {
    default = 1
    description = "number of grafana replicas"
    type    = number
}
variable "grafana-ingress-enabled" {
    default = false
    description = "grafana ingress"
    type    = bool
}
variable "grafana-ingress-host" {
    default = ["grafana.example.com"]
    description = "list of grafana hosts"
    type    = list
}
variable "grafana-persistence-enabled" {
    default = true
    description = "grafana persistence"
    type    = bool
}
variable "grafana-persistence-storageClassName" {
    default = "default"
    description = "grafana storage class name"
    type    = string
}
variable "grafana-persistence-size" {
    default = "10Gi"
    description = "grafana persistence size"
    type    = string
}
variable "grafana-plugins" {
    default = "yesoreyeram-infinity-datasource"
    description = "grafana plugins"
    type    = string
}

/**
  * Jaeger
*/

/**
  * Prometheus
*/

/**
  * Sentry
*/
variable "sentry_postgresql_password" {
  default = "admin"
  description = "default postgresql password"
  type    = string
}