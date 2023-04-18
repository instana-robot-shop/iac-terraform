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
  default = "logging"
}

/*****************************************
  * For Logging
*/

/**
  * APM Server
*/
variable "apm-server-version" {
    default = "8.5.1"
    description = "apm server version"
    type  = string
}

/**
  * ElasticSearch
*/
variable "elasticsearch-version" {
    default = "8.5.1"
    description = "elasticsearch version"
    type  = string
}
variable "elasticsearch-credentials-username" {
    default = "elastic"
    description = "default elasticsearch username"
    type    = string
}
variable "elasticsearch-credentials-password" {
    default = "admin"
    description = "default elasticsearch password"
    type    = string
}
variable "elasticsearch-ingress-enabled" {
    default = false
    description = "elasticsearch ingress"
    type    = bool
}
variable "elasticsearch-ingress-host" {
    default = "elasticsearch.example.com"
    description = "elasticsearch ingress host"
    type    = string
}
variable "elasticsearch-esJavaOpts" {
    default = "-Xmx1g -Xms1g"
    description = "JVM options"
    type    = string
}
variable "elasticsearch-persistence-size" {
    default = "30Gi"
    description = "elasticsearch persistence size per pod"
    type    = string
}

/**
  * Filebeat
*/
variable "filebeat-version" {
    default = "8.5.1"
    description = "filebeat version"
    type  = string
}
variable "filebeat-daemonset-enabled" {
    default = true
    description = "metricbeat daemonset"
    type    = bool
}
variable "filebeat-deployment-enabled" {
    default = false
    description = "filebeat deployment"
    type    = bool
}
variable "filebeat-purger-schedule" {
    // every 24H
    default = "0 0 * * *"
    description = "CronJob which cleaning up filebeat data from elasticsearch (default:every 24H)"
    type    = string
}

/**
  * Kibana
*/
variable "kibana-version" {
    default = "8.5.1"
    description = "kibana version"
    type  = string
}
variable "kibana-replicas" {
    default = 1
    description = "kibana replicas"
    type    = number
}
variable "kibana-ingress-enabled" {
    default = false
    description = "kibana ingress"
    type    = bool
}
variable "kibana-ingress-host" {
    default = "kibana.example.com"
    description = "elasticsearch ingress host"
    type    = string
}

/**
  * Metricbeat
*/
variable "metricbeat-version" {
    default = "8.5.1"
    description = "metricbeat version"
    type  = string
}
variable "kubestate-enabled" {
    default = true
    description = "enable kube-state-metrics deployment for metricbeat"
    type    = bool
}
variable "metricbeat-daemonset-enabled" {
    default = true
    description = "metricbeat daemonset"
    type    = bool
}
variable "metricbeat-purger-schedule" {
    // every 24H
    default = "0 0 * * *"
    description = "CronJob which cleaning up metricbeat data from elasticsearch (default:every 24H)"
    type    = string
}