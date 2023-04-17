# Flux Conductr - GitOps Everything 🧪

The primary goal of this project is to exercise and experiment with [flux](https://fluxcd.io/) based [GitOps](https://gitops.tech) deployment covering the cycle - up to production via promotion, if you want to. Experimentation and production do not have to conflict.

The change process starts at localhost. Hence, we consider localhost experience (`kind` and maybe `k3s` soon) very important. That aim is reflected by the way we expose services locally. There is another strong emphasis on fast feedback. We want things to be available quickly. That includes issues surfacing. Hence, we deeply care about observability. 

Many elements should be useful in CI context. Most things however, should play nice on produtive environments as well.

This repo is mostly based on [flux2-kustomize-helm-example](https://github.com/fluxcd/flux2-kustomize-helm-example). The docs over there should still be pretty accurate.

At the moment, we cover deployments of:
- Terraform resources (via `tf-controller`)
- Cilium
- Metallb
- Knative
- Istio/Zipkin/Kiali
- Contour
- Kube-Prometheus
- Loki/Promtail
- Flagger
- Flamingo/Flux Subsystem for Argo
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
- Naming?
- Deduplicate/Dry things
- ~~Setup "envs" properly / remove literals~~
- Flux Dashboard
- [Grafana/Prometheus](https://fluxcd.io/flux/guides/monitoring/)?
- Demo: Flagger/Rolling/Blue/Green/Canary
- Improve Github Actions Quality Gates
- Local k3s (Speed?)
- ~~Borrow bits from Tanzu? (Does not appear to make sense in flux focused context)~~
- Manage github with `terraform`/crossplane
- babashka scripting?
- `tfctl` app/`terraform` plan approval via ChatOps (Slack?)
- Basic sops/lastpass/github key managment?
- ~~knative?~~
- ~~Replace Contour with Istio~~ ?
- ~~Contour appears to play with knative, kind and flux! (use from bitnami)~~
- Provide tool to wipe (shipping) encrypted secrets
- Default to auto update everything?
- ~~Leverage `metallb.universe.tf/allow-shared-ip: "flux-conductr"` annotation to share/simplify IP address usage~~
- External (M)DNS
- Migrate zipkin to helm
- Introduce Kyverno
- Enable Flagger/Knative with Istio
- ~~Enable Alerting to Slack/Discord (needs [alertmanager-discord](https://github.com/masgustavos/alertmanager-discord))~~
- ~~Integrate Cilium Metrics/Monitoring~~
- [tf-controller : failed to verify artifact: computed checksum](https://github.com/weaveworks/tf-controller/issues/557)
- Consider migrating `make` to [`just`](https://github.com/casey/just)
- Introduce [`resmoio/kubernetes-event-exporter`](https://github.com/resmoio/kubernetes-event-exporter)
- The `infra` / `config` `Kustomization` naming borrowed from `flux2-kustomize-helm-example` is not ideal. It's mostly about dependencies. Hence, the `wave` terminology from `argcocd` might be a bit better. Also, it is about concurrency.
- ~~[Hubble UI displays Trying to reconnect streams and Datastream has failed on UI backend: EOF #21582](https://github.com/cilium/cilium/issues/21582)~~

## Misc/Random Bits
- ~~[Kind cluster with Cilium and no kube-proxy](https://medium.com/@charled.breteche/kind-cluster-with-cilium-and-no-kube-proxy-c6f4d84b5a9d)~~
- [Cilium Grafana Observability Demo](https://github.com/isovalent/cilium-grafana-observability-demo)
- [Install Knative using quickstart](https://knative.dev/docs/getting-started/quickstart-install/)