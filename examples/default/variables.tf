variable "client_id" {
  description = "Client ID that will be used by the aws-health-exporter."
  type        = string
}

variable "client_secret" {
  description = "Client secret that will be used by aws-health-exporter."
  type        = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}
