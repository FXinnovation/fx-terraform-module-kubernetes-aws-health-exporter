#####
# Global
#####

output "selector_labels" {
  description = "Map of the labels that are used as selectors."
  value       = module.default.selector_labels
}

output "image_name" {
  description = "Name of the docker image used for the cloudwatch-exporter container."
  value       = module.default.image_name
}

output "image_version" {
  description = "Tag of the docker image used for the cloudwatch-exporter container."
  value       = module.default.image_version
}

output "image_pull_policy" {
  description = "Image pull policy defined on the cloudwatch-exporter container."
  value       = module.default.image_pull_policy
}

output "grafana_dashboards" {
  description = "List of grafana dashboards"
  value       = module.default.grafana_dashboards
}

#####
# Deployment
#####

output "deployment_name" {
  description = "Name of the deployment created by the module."
  value       = module.default.deployment_name
}

output "deployment_annotations" {
  description = "Map of annotations that are configured on the deployment."
  value       = module.default.deployment_annotations
}

output "deployment_labels" {
  description = "Map of labels that are configured on the deployment."
  value       = module.default.deployment_labels
}

output "deployment_template_annotations" {
  description = "Map of annotations that are configured on the deployment."
  value       = module.default.deployment_template_annotations
}

output "deployment_template_labels" {
  description = "Map of labels that are configured on the deployment."
  value       = module.default.deployment_template_labels
}

#####
# Sercret
#####

output "secret_name" {
  description = "Name of the secret created by the module."
  value       = module.default.secret_name
}

output "secret_annotations" {
  description = "Map of annotations that are configured on the secret."
  value       = module.default.secret_annotations
}

output "secret_labels" {
  description = "Map of labels that are configured on the secret."
  value       = module.default.secret_labels
}

#####
# Service
#####

output "service_name" {
  description = "Name of the service created by the module."
  value       = module.default.service_name
}

output "service_port" {
  description = "Port number of the service port."
  value       = module.default.service_port
}

output "service_port_name" {
  description = "Name of the service port."
  value       = module.default.service_port_name
}

output "service_annotations" {
  description = "Map of annotations that are configured on the service."
  value       = module.default.service_annotations
}

output "service_labels" {
  description = "Map of labels that are configured on the service."
  value       = module.default.service_labels
}

#####
# Namespace
#####

output "namespace" {
  description = "Name of the namespace in which the resources have been deployed."
  value       = module.default.namespace
}
