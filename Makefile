KUBECTL=kubectl
SSH_PUB_KEY=keys/flux-conductr.pub

.DEFAULT_GOAL := help

.PHONY: help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: gen-keys
gen-keys: ## Generate ssh keys
	./script/gen-keys.sh

.PHONY: gh-add-deploy-key
gh-add-deploy-key: ## Add Deployment key to github
	gh repo deploy-key add keys $(SSH_PUB_KEY)

.PHONY: image-summary
image-summary: ## Show deployed images
	$(KUBECTL) get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | grep -v quay.io/openshift/okd-content | sort | uniq -c | sort -n | tac

# .PHONY: all-loadbalancer-services
# all-loadbalancer-services: ## Show all loadbalancer services
# 	$(KUBECTL) get svc -A -o jsonpath='{range .items[?(@.spec.type=="LoadBalancer")]}{.status.loadBalancer.ingress[].ip}:{.spec.ports[].port}{"\n"}{end}'

# TODO: WIP - something along those lines should be faster than recreating the docker container - while we mess around
# iptables -t nat -A  DOCKER -p tcp --dport 3000 -j DNAT --to-destination 172.18.255.200:3000 -m comment --comment 'flux-conductr LB to 3000'
# iptables -t nat -L DOCKER --line-number
# iptables -t nat -D DOCKER ${line_number}

.PHONY: show-kiali-token
show-kiali-token: ## Show kiali token
	@$(KUBECTL) -n istio-system get $$($(KUBECTL) -n istio-system get secret -o name | grep secret/kiali) --template={{.data.token}} | base64 --decode; echo

target:
	mkdir target

.PHONY: fmt
fmt: ## Format
	terraform fmt --check --recursive

.PHONY: lint
lint: ## Lint
	tflint --recursive

PHONY: validate
validate: ## Validate YAML
	./scripts/validate.sh