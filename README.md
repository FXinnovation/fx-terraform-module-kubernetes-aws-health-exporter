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
| deployment\_name | Name of the deployment created by the module. |
| secret\_name | Name of the secret created by the module. |
| service\_name | Name of the service created by the module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
