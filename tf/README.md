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
| cilium\_helmrelease\_path | n/a | `string` | `"../infrastructure/lib/config/cilium/release-cilium.yaml"` | no |
| dns\_hosts | n/a | `map(string)` | `null` | no |
| extra\_mounts | n/a | `list(map(string))` | `[]` | no |
| extra\_port\_mappings | n/a | `list(map(string))` | <pre>[<br>  {<br>    "container_port": 30080,<br>    "host_port": 3000<br>  },<br>  {<br>    "container_port": 30180,<br>    "host_port": 3100<br>  },<br>  {<br>    "container_port": 30280,<br>    "host_port": 9411<br>  },<br>  {<br>    "container_port": 30380,<br>    "host_port": 10080<br>  },<br>  {<br>    "container_port": 30480,<br>    "host_port": 10180<br>  },<br>  {<br>    "container_port": 30580,<br>    "host_port": 10280<br>  }<br>]</pre> | no |
| flux\_kustomization\_path | n/a | `string` | `"../clusters/local/flux-system"` | no |
| id\_rsa\_fluxbot\_ro\_path | n/a | `string` | `null` | no |
| id\_rsa\_fluxbot\_ro\_pub\_path | n/a | `string` | `null` | no |
| kind\_cluster\_image | n/a | `string` | `"kindest/node:v1.25.8"` | no |
| kind\_cluster\_name | Cluster name | `string` | `"flux-conductr"` | no |
| metallb | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster | Object describing the whole created project |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->