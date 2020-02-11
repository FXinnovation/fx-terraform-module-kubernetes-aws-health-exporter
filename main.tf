#####
# Locals
#####

locals {
  labels = {
    "app.kubernetes.io/version"    = var.image_version
    "app.kubernetes.io/component"  = "exporter"
    "app.kubernetes.io/part-of"    = "monitoring"
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/name"       = "aws-health-exporter"
  }
  port = 9383
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  number  = false
  length  = 8
}

#####
# Deployment
#####

resource "kubernetes_deployment" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.deployment_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.deployment_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.deployment_name
      },
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app    = "aws-health-exporter"
        random = random_string.selector.result
      }
    }
    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_annotations
        )
        labels = merge(
          {
            "app.kubernetes.io/instance" = var.deployment_name
            app                          = "aws-health-exporter"
            random                       = random_string.selector.result
          },
          local.labels,
          var.labels,
          var.deployment_labels
        )
      }
      spec {
        container {
          name              = "aws-health-exporter"
          image             = "${var.image_name}:${var.image_version}"
          image_pull_policy = var.image_pull_policy

          args = var.container_args

          env {
            name = "AWS_ACCESS_KEY_ID"
            value_from {
              secret_key_ref {
                name = element(concat(kubernetes_secret.this.*.metadata.0.name, [""]), 0)
                key  = "access_key"
              }
            }
          }

          env {
            name = "AWS_SECRET_ACCESS_KEY"
            value_from {
              secret_key_ref {
                name = element(concat(kubernetes_secret.this.*.metadata.0.name, [""]), 0)
                key  = "secret_key"
              }
            }
          }

          readiness_probe {
            http_get {
              path   = "/"
              port   = local.port
              scheme = "HTTP"
            }

            timeout_seconds   = 5
            period_seconds    = 5
            success_threshold = 1
            failure_threshold = 35
          }

          liveness_probe {
            http_get {
              path   = "/"
              port   = local.port
              scheme = "HTTP"
            }

            timeout_seconds   = 5
            period_seconds    = 10
            success_threshold = 1
            failure_threshold = 3
          }

          port {
            name           = "http"
            container_port = local.port
            protocol       = "TCP"
          }

          resources {
            requests {
              memory = "32Mi"
              cpu    = "5m"
            }
            limits {
              memory = "64Mi"
              cpu    = "20m"
            }
          }
        }
      }
    }
  }
}


#####
# Service
#####

resource "kubernetes_service" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.service_name
    namespace = var.namespace
    annotations = merge(
      {
        "prometheus.io/scrape" = "true"
      },
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.service_name
      },
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      random = random_string.selector.result
      app    = "aws-health-exporter"
    }
    type = "ClusterIP"
    port {
      port        = 80
      target_port = "http"
      protocol    = "TCP"
      name        = "http"
    }
  }
}

#####
# Secret
#####

resource "kubernetes_secret" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.secret_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.secret_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.secret_name
      },
      var.labels,
      var.secret_labels
    )
  }

  data = {
    access_key = var.access_key
    secret_key = var.secret_key
  }

  type = "Opaque"
}
