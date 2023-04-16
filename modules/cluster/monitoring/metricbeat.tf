resource "helm_release" "metricbeat" {
  #   depends_on = [helm_release.elasticsearch,helm_release.kibana]
  name  = "metricbeat"
  repository = "https://helm.elastic.co"
  chart = "metricbeat"
  namespace = var.namespace
  atomic = true
  cleanup_on_fail = true
  values = [
    file("${path.module}/configs/metricbeat-values.yaml")
  ]
  set {
    name  = "imageTag"
    value = var.metricbeat-version
  }
  set {
    name  = "deployment.enabled"
    value = var.kubestate-enabled
  }
  set {
    name  = "kube_state_metrics.enabled"
    value = var.kubestate-enabled
  }
  set {
    name  = "daemonset.enabled"
    value = var.metricbeat-daemonset-enabled
  }

}

resource "kubernetes_cron_job" "elasticsearch-metricbeat-purger" {
  metadata {
    name = "elasticsearch-metricbeat-purger"
    namespace = var.namespace
  }
  spec {
    failed_jobs_history_limit     = 2
    schedule                      = var.metricbeat-purger-schedule
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name    = "elasticsearch-metricbeat-purger"
              image   = "ubuntu:focal"
              command = ["/bin/bash","-c"]
              args    = ["apt update && apt install curl --yes && curl -u $username:$password -XDELETE http://elasticsearch-master:9200/metricbeat-*-`date -d'1 days ago' +'%Y.%m.%d'`*"]

              env_from {
                secret_ref {
                  name = "elasticsearch-credentials"
                }
              }
              security_context {
                allow_privilege_escalation = false
                run_as_user = 0
              }

            }
          }
        }
      }
    }
  }
}