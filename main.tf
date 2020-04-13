#####
# Locals
#####

locals {
  labels = {
    "version"    = var.image_version
    "component"  = "exporter"
    "part-of"    = "monitoring"
    "managed-by" = "terraform"
    "name"       = "aws-health-exporter"
  }
  port         = 9383
  service_port = 80
  prometheus_alert_groups_rules_annotations = merge(
    {},
    var.prometheus_alert_groups_rules_annotations
  )
  prometheus_alert_groups_rules_labels = merge(
    {
      "source" = "https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-kubernetes-aws-health-exporter"
    },
    var.prometheus_alert_groups_rules_labels
  )
  prometheus_alert_groups = [
    {
      "name" = "aws-health"
      "rules" = [
        {
          "alert" = "aws-health - open scheduled changes"
          "expr"  = "aws_health_events{category=\"scheduledChanges\",status_code=\"open\"} > 0"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"              = "AWS Health - Open Scheduled Change"
              "description"          = "AWS Health:\n There is an open scheduled change on service {{ $labels.service }} in region {{ $labels.region }}."
              "description_html"     = "<h3>AWS Health</h3><p>There is an open scheduled change on service {{ $labels.service }} in region {{ $labels.region }}.</p>"
              "description_markdown" = "### AWS Health\nThere is an open scheduled change on service {{ $labels.service }} in region {{ $labels.region }}."
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "aws-health - open issues"
          "expr"  = "aws_health_events{category=\"issue\",status_code=\"open\"} > 0"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"              = "AWS Health - Open Issue"
              "description"          = "AWS Health:\n There is an open issue on service {{ $labels.service }} in region {{ $labels.region }}."
              "description_html"     = "<h3>AWS Health</h3><p>There is an open issue on service {{ $labels.service }} in region {{ $labels.region }}.</p>"
              "description_markdown" = "### AWS Health\nThere is an open issue on service {{ $labels.service }} in region {{ $labels.region }}."
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "aws-health - open account notifications"
          "expr"  = "aws_health_events{category=\"accountNotification\",status_code=\"open\"} > 0"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"              = "AWS Health - Open Account Notification"
              "description"          = "AWS Health:\n There is an open account notification on service {{ $labels.service }} in region {{ $labels.region }}."
              "description_html"     = "<h3>AWS Health</h3><p>There is an open account notification on service {{ $labels.service }} in region {{ $labels.region }}.</p>"
              "description_markdown" = "### AWS Health\nThere is an open account notification on service {{ $labels.service }} in region {{ $labels.region }}."
            },
            local.prometheus_alert_groups_rules_annotations
          )
        }
      ]
    }
  ]
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
        "instance" = var.deployment_name
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
        selector = "aws-health-exporter-${random_string.selector.result}"
      }
    }
    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_template_annotations
        )
        labels = merge(
          {
            "instance" = var.deployment_name
            selector   = "aws-health-exporter-${random_string.selector.result}"
          },
          local.labels,
          var.labels,
          var.deployment_template_labels
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
        "instance" = var.service_name
      },
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      selector = "aws-health-exporter-${random_string.selector.result}"
    }
    type = "ClusterIP"
    port {
      port        = local.service_port
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
        "instance" = var.secret_name
      },
      local.labels,
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
