resource "helm_release" "filebeat" {
  #   depends_on = [helm_release.elasticsearch,helm_release.kibana]
  name  = "filebeat"
  repository = "https://helm.elastic.co"
  chart = "filebeat"
  namespace = var.namespace
  atomic = true
  timeout = 100
  cleanup_on_fail = true
  values = [
    file("${path.module}/configs/filebeat-values.yaml")
  ]
  set {
    name  = "imageTag"
    value = var.filebeat-version
  }
  set {
    name  = "daemonset.enabled"
    value = var.filebeat-daemonset-enabled
  }
  set {
    name  = "deployment.enabled"
    value = var.filebeat-deployment-enabled
  }

}

resource "kubernetes_cron_job" "elastic-filebeat-purger" {
  metadata {
    name = "elasticsearch-filebeat-purger"
    namespace = var.namespace
  }
  spec {
    failed_jobs_history_limit     = 2
    schedule                      = var.filebeat-purger-schedule
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
              name    = "elasticsearch-filebeat-purger"
              image   = "ubuntu:focal"
              command = ["/bin/bash","-c"]
              args    = ["apt update && apt install curl --yes && curl -u $username:$password -XDELETE http://elasticsearch-master:9200/filebeat-*-`date -d'1 days ago' +'%Y.%m.%d'`*"]

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
