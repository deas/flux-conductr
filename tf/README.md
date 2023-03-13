# terraform infra for flux conductr

## Usage
```shell
cp sample.tfvars terraform.tfvars
# Set proper values in terraform.tfvars
terraform apply
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_keys | n/a | `map(any)` | `{}` | no |
| flux\_kustomization\_path | n/a | `string` | `"../clusters/local/flux-system"` | no |
| id\_rsa\_fluxbot\_ro\_path | n/a | `string` | `null` | no |
| id\_rsa\_fluxbot\_ro\_pub\_path | n/a | `string` | `null` | no |
| kind\_cluster\_name | Cluster name | `string` | `"flux-conductr"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster | Object describing the whole created project |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->