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
# In case you want to expose with kind
# extra_port_mappings = [
#   {
#     container_port = 30080
#     host_port      = 3000 # Grafana
#   },
#   {
#     container_port = 30180
#     host_port      = 3100 # Loki
#   },
#   {
#     container_port = 30280
#     host_port      = 9411 # Zipkin
#   },
#   {
#     container_port = 30380
#     host_port      = 10080 # Istio-Ingress
#   },
#   {
#     container_port = 30480
#     host_port      = 10180 # Weave-GitOps
#   },
#   {
#     container_port = 30580
#     host_port      = 10280 # Hubble-UI
#   }
# ]
#
# https://maelvls.dev/docker-proxy-registry-kind/
# containerd_config_patches = [
#   <<-EOF
#           [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
#             endpoint = ["http://docker-proxy:5000"]
#           [plugins."io.containerd.grpc.v1.cri".registry.mirrors."quay.io"]
#             endpoint = ["http://quay-proxy:5000"]
#           [plugins."io.containerd.grpc.v1.cri".registry.mirrors."registry.k8s.io"]
#             endpoint = ["http://k8s-proxy:5000"]
#           [plugins."io.containerd.grpc.v1.cri".registry.mirrors."ghcr.io"]
#             endpoint = ["http://ghcr-proxy:5000"]
#           [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
#             endpoint = ["http://registry:5000"]
#           EOF
# ]
# flux_kustomization_path         = "../clusters/local/flux-system"
#cluster = "local"

id_rsa_fluxbot_ro_path     = "../keys/id_rsa-flux-conductr"
id_rsa_fluxbot_ro_pub_path = "../keys/id_rsa-flux-conductr.pub"
additional_keys            = { "sops-gpg" = { "sops.asc" = "../keys/flux-conductr-priv.asc" } }

