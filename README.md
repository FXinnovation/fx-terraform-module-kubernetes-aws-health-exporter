# terraform-module-kubernetes-aws-health-exporter

Terraform module to deploy aws-health-exporter on kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| access\_key | Client ID that will be used by the aws-health-exporter. | `string` | n/a | yes |
| annotations | Additionnal annotations that will be merged on all resources. | `map` | `{}` | no |
| container\_args | List of additionnal arguments passed to the container. | `list` | `[]` | no |
| deployment\_annotations | Additionnal annotations that will be merged on the deployment. | `map` | `{}` | no |
| deployment\_labels | Additionnal labels that will be merged on the deployment. | `map` | `{}` | no |
| deployment\_name | Name of the deployment that will be create. | `string` | `"aws-health-exporter"` | no |
| deployment\_template\_annotations | Additionnal annotations that will be merged on the deployment template. | `map` | `{}` | no |
| deployment\_template\_labels | Additionnal labels that will be merged on the deployment template. | `map` | `{}` | no |
| enabled | Whether or not to enable this module. | `bool` | `true` | no |
| image\_name | Name of the docker image to use. | `string` | `"jimdo/aws-health-exporter"` | no |
| image\_pull\_policy | Image pull policy on the main container. | `string` | `"IfNotPresent"` | no |
| image\_version | Tag of the docker image to use. | `string` | `"latest"` | no |
| labels | Additionnal labels that will be merged on all resources. | `map` | `{}` | no |
| namespace | Namespace in which the module will be deployed. | `string` | `"default"` | no |
| replicas | Number of replicas to deploy. | `number` | `1` | no |
| secret\_annotations | Additionnal annotations that will be merged for the secret. | `map` | `{}` | no |
| secret\_key | Client secret that will be used by the aws-health-exporter. | `string` | n/a | yes |
| secret\_labels | Additionnal labels that will be merged for the secret. | `map` | `{}` | no |
| secret\_name | Name of the secret that will be created. | `string` | `"aws-health-exporter"` | no |
| service\_annotations | Additionnal annotations that will be merged for the service. | `map` | `{}` | no |
| service\_labels | Additionnal labels that will be merged for the service. | `map` | `{}` | no |
| service\_name | Name of the service that will be create | `string` | `"aws-health-exporter"` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_annotations | Map of annotations that are configured on the deployment. |
| deployment\_labels | Map of labels that are configured on the deployment. |
| deployment\_name | Name of the deployment created by the module. |
| deployment\_template\_annotations | Map of annotations that are configured on the deployment. |
| deployment\_template\_labels | Map of labels that are configured on the deployment. |
| grafana\_dashboards | List of strings, each one representing a separate grafana dashboard. |
| image\_name | Name of the docker image used for the aws-health-status container. |
| image\_pull\_policy | Image pull policy defined on the aws-health-status container. |
| image\_version | Tag of the docker image used for the aws-health-status container. |
| namespace | Name of the namespace in which the resources have been deployed. |
| prometheus\_alert\_groups | List of maps representing prometheus alerts. |
| secret\_annotations | Map of annotations that are configured on the secret. |
| secret\_labels | Map of labels that are configured on the secret. |
| secret\_name | Name of the secret created by the module. |
| selector\_labels | Map of the labels that are used as selectors. |
| service\_annotations | Map of annotations that are configured on the service. |
| service\_labels | Map of labels that are configured on the service. |
| service\_name | Name of the service created by the module. |
| service\_port | Port number of the service port. |
| service\_port\_name | Name of the service port. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### grafana_dashboards

### prometheus_alert_groups
