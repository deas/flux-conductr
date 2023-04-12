# https://github.com/hashicorp/terraform/issues/28580#issuecomment-831263879
terraform {
  required_version = ">= 1.2"

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = ">= 0.0.14"
    }
    /*
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }*/
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.7.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = ">= 0.9.2"
    }

    /* flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }*/
  }
}


provider "helm" {
  kubernetes {
    # config_path = kind_cluster.default.kubeconfig
    host                   = kind_cluster.default.endpoint
    client_certificate     = kind_cluster.default.client_certificate
    client_key             = kind_cluster.default.client_key
    cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
  }
}

provider "kind" {
}

provider "kubernetes" {
  # config_path = kind_cluster.default.kubeconfig
  # config_context = "kind-flux"
  host                   = kind_cluster.default.endpoint
  client_certificate     = kind_cluster.default.client_certificate
  client_key             = kind_cluster.default.client_key
  cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
}

provider "kubectl" {
  host                   = kind_cluster.default.endpoint
  client_certificate     = kind_cluster.default.client_certificate
  client_key             = kind_cluster.default.client_key
  cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
  # token                  = data.aws_eks_cluster_auth.main.token
  load_config_file = false
}

provider "kustomization" {
  kubeconfig_raw = kind_cluster.default.kubeconfig
}

locals {
  additional_keys = zipmap(
    keys(var.additional_keys),
    [for secret in values(var.additional_keys) :
      zipmap(
        keys(secret),
      [for path in values(secret) : file(path)])
  ])
}

resource "kind_cluster" "default" {
  name           = var.kind_cluster_name
  wait_for_ready = false # true # false likely needed for cilium bootstrap
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role  = "control-plane"
      image = var.kind_cluster_image
      dynamic "extra_mounts" {
        for_each = var.extra_mounts
        content {
          container_path = extra_mounts.value["container_path"]
          host_path      = extra_mounts.value["host_path"]
        }
      }
    }

    #node {
    #  role = "worker"
    #  image = "kindest/node:v1.19.1"
    #}
    # Guess this will work as the creation changes to context?

    networking {
      disable_default_cni = var.cilium_version != null                       # do not install kindnet for cilium
      kube_proxy_mode     = var.cilium_version != null ? "none" : "iptables" # do not run kube-proxy for cilium
    }

  }
  // TODO: Should be covered by wait_for_ready?
  provisioner "local-exec" {
    command = "kubectl -n kube-system wait --timeout=180s --for=condition=ready pod -l tier=control-plane"
  }
}

data "http" "metallb_native" {
  count = var.metallb ? 1 : 0
  url   = "https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml"
}

module "metallb_config" {
  count  = var.metallb ? 1 : 0
  source = "github.com/deas/terraform-modules//kind-metallb?ref=main"
}

module "metallb" {
  count  = var.metallb ? 1 : 0
  source = "github.com/deas/terraform-modules//metallb?ref=main"
  # source           = "../../terraform-modules/metallb"
  install_manifest = data.http.metallb_native[0].response_body
  config_manifest  = module.metallb_config[0].manifest
}

# Be careful with this module. It will patch coredns configmap ;)
module "coredns" {
  # version
  # source          = "../../terraform-modules/coredns"
  source = "github.com/deas/terraform-modules//coredns?ref=main"
  hosts  = var.dns_hosts
  count  = var.dns_hosts != null ? 1 : 0
  providers = {
    kubectl = kubectl
  }
}

# Bare minimum to get CNI up here (Won't work via flux)
resource "helm_release" "cilium" {
  count      = var.cilium_version != null ? 1 : 0
  name       = "cilium"
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = var.cilium_version
  namespace  = "kube-system"
  values     = [file("cilium-values.yaml")]
}

module "flux" {
  # TODO: Replace kubectl with kustomize in the flux module
  source = "github.com/deas/terraform-modules//flux?ref=main"
  # source    = "../../terraform-modules/flux"
  namespace = "flux-system"
  # bootstrap_manifest = try(file(var.bootstrap_path), null)
  kustomization_path = var.flux_kustomization_path
  tls_key = {
    private = file(var.id_rsa_fluxbot_ro_path)
    public  = file(var.id_rsa_fluxbot_ro_pub_path)
  }
  additional_keys = local.additional_keys
  #tls_key = {
  #  private = module.secrets.secret["id-rsa-fluxbot-ro"].secret_data
  #  public  = module.secrets.secret["id-rsa-fluxbot-ro-pub"].secret_data
  #}
  #additional_keys = {
  #  sops-gpg = {
  #    "sops.asc" = module.secrets.secret["sops-gpg"].secret_data
  #  }
  #}
  providers = {
    kubernetes    = kubernetes
    kubectl       = kubectl
    kustomization = kustomization
  }
}

/*
module "secrets" {
  source = "../../../google-secrets"
  gcp_credentials = var.gcp_secrets_credentials
  project_id      = var.gcp_secrets_project_id
  secrets         = var.flux_secrets
}
*/

# Ugly git submodule workaround
#module "flux-manifests" {
#  source = "git::https://github.com/.../foo-deployment.git//clusters/test/flux-system"
#}

#data "flux_install" "main" {
#  # count       = var.github_init ? 1 : 0
#  target_path = var.target_path
#}
