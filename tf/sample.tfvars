# flux_kustomization_path         = "../clusters/local/flux-system"
#cluster = "local"
id_rsa_fluxbot_ro_path     = "../keys/id_rsa-flux-conductr"
id_rsa_fluxbot_ro_pub_path = "../keys/id_rsa-flux-conductr.pub"
additional_keys            = { "sops-gpg" = { "sops.asc" = "../keys/flux-conductr-priv.asc" } }
