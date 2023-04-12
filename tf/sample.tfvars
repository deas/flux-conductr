# kind_cluster_image = "kindest/node:v1.23.13"
# metallb           = true
# Sample overrides for local-proxy
# flux_kustomization_path = "../clusters/local-proxy/flux-system"
# bootstrap_path  = "../target/manifest-ca-certs.yaml"
# dns_hosts = { "192.168.1.121" = "proxy.local" }
# id_rsa_ro_path     = "../keys/id_rsa-ka0s"
# id_rsa_ro_pub_path = "../keys/id_rsa-ka0s.pub"
# additional_keys            = { "sops-gpg" = { "sops.asc" = "../keys/ka0s-priv.asc" } }
# extra_mounts = [{
#   "container_path" = "/etc/ssl/certs/ca-certificates.crt"
#   "host_path"      = "/etc/ssl/certs/ca-certificates.crt"
# }]
# flux_kustomization_path         = "../clusters/local/flux-system"
#cluster = "local"

id_rsa_fluxbot_ro_path     = "../keys/id_rsa-flux-conductr"
id_rsa_fluxbot_ro_pub_path = "../keys/id_rsa-flux-conductr.pub"
additional_keys            = { "sops-gpg" = { "sops.asc" = "../keys/flux-conductr-priv.asc" } }

