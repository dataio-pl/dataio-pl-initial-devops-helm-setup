# terraform-helm-release

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atomic"></a> [atomic](#input\_atomic) | If set, installation process purges chart on fail | `bool` | `false` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed | `string` | `""` | no |
| <a name="input_chart_values"></a> [chart\_values](#input\_chart\_values) | List of values in raw yaml to pass to helm | `list(any)` | `[]` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact chart version to install | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Set release description attribute | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set it to true to create the Helm Release in the cluster | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the release into. Defaults to default | `string` | `"default"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart | `string` | `""` | no |
| <a name="input_set"></a> [set](#input\_set) | Value block with custom values to be merged with the values yaml | `map(any)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff | `map(any)` | `{}` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until all resources are in a ready state before marking the release as successful | `bool` | `false` | no |

## Outputs

No outputs.
