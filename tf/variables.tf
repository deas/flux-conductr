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
  default = null
}

variable "cilium_version" {
  type    = string
  default = "1.13.1"
}

/*
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

variable "metallb" {
  type    = bool
  default = true
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
