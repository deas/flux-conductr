#variable "github_token" {
#  type        = string
#  description = "github token"
#}

variable "kind_cluster_name" {
  type        = string
  description = "Cluster name"
  default     = "flux-conductr"
}

variable "kind_cluster_image" {
  type    = string
  default = "kindest/node:v1.25.8"
}

variable "cilium_helmrelease_path" {
  type    = string
  default = "../infrastructure/lib/config/cilium/release-cilium.yaml"
}

/*
variable "cilium_version" {
  type    = string
  default = "1.13.1"
}

variable "github_init" {
  type        = bool
  default     = false
  description = "Initialize github files"
}
*/

variable "id_rsa_fluxbot_ro_path" {
  type    = string
  default = null
}

variable "id_rsa_fluxbot_ro_pub_path" {
  type    = string
  default = null
}

variable "additional_keys" {
  type    = map(any)
  default = {}
}

variable "flux_kustomization_path" {
  type    = string
  default = "../clusters/local/flux-system"
}

variable "dns_hosts" {
  type    = map(string)
  default = null
}

variable "extra_mounts" {
  type    = list(map(string))
  default = []
}

variable "extra_port_mappings" {
  type = list(map(string))
  default = [
    {
      container_port = 30080
      host_port      = 3000 # Grafana
    },
    {
      container_port = 30180
      host_port      = 3100 # Loki
    },
    {
      container_port = 30280
      host_port      = 9411 # Zipkin
    },
    {
      container_port = 30380
      host_port      = 10080 # Istio-Ingress
    },
    {
      container_port = 30480
      host_port      = 10180 # Weave-GitOps
    },
    {
      container_port = 30580
      host_port      = 10280 # Hubble-UI
    }
  ]
}

variable "metallb" {
  type    = bool
  default = false
}

/*
variable "gcp_secrets_credentials" {
  type = string
}

variable "gcp_secrets_project_id" {
  type = string
}

variable "flux_secrets" {
  type = set(string)
}

variable "cluster" {
  type = string
}
*/
