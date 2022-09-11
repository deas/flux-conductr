# Flux based GitOps - Incubator

Flux based [GitOps](https://gitops.tech) for Haute Cuisine - mostly based on [flux2-kustomize-helm-example](https://github.com/fluxcd/flux2-kustomize-helm-example) so the docs over there should still be pretty accurate.


## Bootrapping

There is a `terraform` + `kind` based bootstrap [example over at `deas/terraform-modules`](https://github.com/deas/terraform-modules/tree/main/flux/examples/kind) in case you want to try it locally or in CI. Rename `sample.tfvars` to `terraform.tfvars` and make sure to adjust values.

Alternatively, you can bootstrap an existing cluster (be sure to have current kube context set properly):

```sh
export GITHUB_TOKEN=...
GITHUB_USER=deas
GITHUB_REPO=flux-incubatr
BRANCH=local
CLUSTER_PATH=clusters/local

flux bootstrap github \
  --owner=${GITHUB_USER} \
  --log-level debug \
  --repository=${GITHUB_REPO} \
  --branch=${BRANCH} \
  --personal \
  --read-write-key \
  --components-extra=image-reflector-controller,image-automation-controller \
  --path=${CLUSTER_PATH}
```


## TODO
- Naming?
- Deduplicate/Dry things
- Setup "envs" properly / remove literals
- Flux Dashboard?
- Grafana/Prometheus?
- Flagger? Rolling, Blue/Green, Canary?
- Prometheus?
- Validation ( -> Monitoring)
- local k3s (Speed?)
- Borrow from Tanzu?
