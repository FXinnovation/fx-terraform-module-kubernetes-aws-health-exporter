#####
# Global
#####

variable "annotations" {
  description = "Additionnal annotations that will be merged on all resources."
  default     = {}
}

variable "enabled" {
  description = "Whether or not to enable this module."
  default     = true
}

variable "labels" {
  description = "Additionnal labels that will be merged on all resources."
  default     = {}
}

variable "namespace" {
  description = "Namespace in which the module will be deployed."
  default     = "default"
}

#####
# Application
#####

variable "access_key" {
  description = "Client ID that will be used by the aws-health-exporter."
  type        = string
}

variable "secret_key" {
  description = "Client secret that will be used by the aws-health-exporter."
  type        = string
}

variable "container_args" {
  description = "List of additionnal arguments passed to the container."
  default     = []
}

#####
# Deployment
#####

variable "deployment_annotations" {
  description = "Additionnal annotations that will be merged on the deployment."
  default     = {}
}

variable "deployment_labels" {
  description = "Additionnal labels that will be merged on the deployment."
  default     = {}
}

variable "deployment_name" {
  description = "Name of the deployment that will be create."
  default     = "aws-health-exporter"
}

variable "deployment_template_annotations" {
  description = "Additionnal annotations that will be merged on the deployment template."
  default     = {}
}

variable "deployment_template_labels" {
  description = "Additionnal labels that will be merged on the deployment template."
  default     = {}
}

variable "image_name" {
  description = "Name of the docker image to use."
  default     = "jimdo/aws-health-exporter"
}

variable "image_pull_policy" {
  description = "Image pull policy on the main container."
  default     = "IfNotPresent"
}

variable "image_version" {
  description = "Tag of the docker image to use."
  default     = "latest"
}

variable "replicas" {
  description = "Number of replicas to deploy."
  default     = 1
}

#####
# Service
#####

variable "service_annotations" {
  description = "Additionnal annotations that will be merged for the service."
  default     = {}
}

variable "service_labels" {
  description = "Additionnal labels that will be merged for the service."
  default     = {}
}

variable "service_name" {
  description = "Name of the service that will be create"
  default     = "aws-health-exporter"
}

#####
# Secret
#####

variable "secret_annotations" {
  description = "Additionnal annotations that will be merged for the secret."
  default     = {}
}

variable "secret_labels" {
  description = "Additionnal labels that will be merged for the secret."
  default     = {}
}

variable "secret_name" {
  description = "Name of the secret that will be created."
  default     = "aws-health-exporter"
}
