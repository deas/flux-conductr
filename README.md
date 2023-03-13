# Flux Conductr - GitOps Everything 🧪

The primary goal of this project is to exercise and experiment with [flux](https://fluxcd.io/) based [GitOps](https://gitops.tech) deployment covering the cycle - up to production via promotion, if you want to. Experimentation and production do not have to conflict.

The change process starts at localhost. Hence, we consider localhost experience (`kind` and maybe `k3s` soon) very important. Given that, some elements may be useful in CI context. Most things however, should play nice on produtive environments as well.

This repo is mostly based on [flux2-kustomize-helm-example](https://github.com/fluxcd/flux2-kustomize-helm-example). The docs over there should still be pretty accurate.

At the moment, we cover deployments of:
- Terraform resources (via `tf-controller`)
- Cilium
- Metallb
- Knative
- Contour
- Kube-Prometheus
- Loki
- Flagger
- Traefik
- WeaveWorks GitOps
- External Secrets
- CSI Secrets
- AWS Credentials Sync
- SOPS Secrets
- Alerting/Notifications via Slack/MS Teams
- Image Reflector/Image Automation

Beyond that, we aim at exploring:
- CrossPlane
- Istio


## Bootrapping
Encryption keys are required for Image Automation and default gpg (sops) based secrets.

To get started, generate encryption keys for ssh/gpg:

```shell
./script/gen-keys.sh
```
Add public deployment key to github. You may also want to disable github actions to start.
```
gh repo deploy-key add ...
```


There is a `terraform` + `kind` based bootstrap in [`tf`](./tf):

```shell
cp sample.tfvars terraform.tfvars
# Set proper values in terraform.tfvars
terraform apply
```
Alternatively, you can bootstrap or even upgrade an existing cluster (be sure to have current kube context set properly). Also, make sure `flux --version` shows desired version.

```sh
./scripts/flux-bootstrap.sh
```

## Known Issues
- knative challenging (Some bits need `kustomize.toolkit.fluxcd.io/substitute: disabled` in our context, other things need tweaks to upstream yaml to play with GitOps "... configured")

## TODO
- Introduce `terraform-modules/kind-metallb`
- Naming?
- Deduplicate/Dry things
- ~~Setup "envs" properly / remove literals~~
- Flux Dashboard?
- [Grafana/Prometheus](https://fluxcd.io/flux/guides/monitoring/)?
- Flagger? Rolling, Blue/Green, Canary?
- Validation ( -> Monitoring)
- local k3s (Speed?)
- Borrow bits from Tanzu?
- Manage github with `terraform`/crossplane
- bb scripting?
- `tfctl` app/`terraform` plan approval via ChatOps (Slack?)
- basic sops/lastpass/github key managment?
- ~~knative?~~
- contour appear to play with knative, kind and flux! (use from bitnami)
- provide tool to wipe (shipping) encrypted secrets
- default to auto update everything?
- Update to recent flux2 version
- Move to nix

## Misc/Random Bits
- ~~[Kind cluster with Cilium and no kube-proxy](https://medium.com/@charled.breteche/kind-cluster-with-cilium-and-no-kube-proxy-c6f4d84b5a9d)~~
- [Cilium Grafana Observability Demo](https://github.com/isovalent/cilium-grafana-observability-demo)
- [Install Knative using quickstart](https://knative.dev/docs/getting-started/quickstart-install/)