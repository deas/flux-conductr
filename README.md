# Flux Conductr - GitOps Everything 🧪

Flux based [GitOps](https://gitops.tech) - orchestrate all the flux things - mostly based on [flux2-kustomize-helm-example](https://github.com/fluxcd/flux2-kustomize-helm-example). The docs over there should still be pretty accurate.

Generate encryption keys for ssh/gpg:

```shell
./script/gen-keys.sh
```
Add public deployment key to github. You may also want to disable github actions to start.
```
gh repo deploy-key add ...
```


## Bootrapping

There is a `terraform` + `kind` based bootstrap in [`tf`](./tf):

```shell
cp sample.tfvars terraform.tfvars
# Set proper values in terraform.tfvars
terraform apply
```
Alternatively, you can bootstrap an existing cluster (be sure to have current kube context set properly):

```sh
./scripts/flux-bootstrap.sh
```

## TODO
- Naming?
- Deduplicate/Dry things
- Setup "envs" properly / remove literals
- Flux Dashboard?
- [Grafana/Prometheus](https://fluxcd.io/flux/guides/monitoring/)?
- Flagger? Rolling, Blue/Green, Canary?
- Validation ( -> Monitoring)
- local k3s (Speed?)
- Borrow from Tanzu?
- Manage github with terraform/crossplane
- bb scripting?
- tfctl app?
- basic sops/lastpass/github key managment?
- knative?
- default to auto update everything?
