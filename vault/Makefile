.PHONY: create cleanup update watch-events

NS?=vault-test
COUCHDB_USERNAME=vault
COUCHDB_PASSWORD=vault

.SILENT: .secret.yaml
../build/secret.yaml:
	kubectl create secret generic vault --from-literal=couchdbUsername=$(COUCHDB_USERNAME) --from-literal=couchdbPassword=$(COUCHDB_PASSWORD) --dry-run=client -o yaml > ../build/secret.yaml

create: ../build/secret.yaml
	kubectl create ns $(NS) --dry-run=client -o yaml > ../build/ns.yaml
	kubectl apply -f ../build/ns.yaml
	kubectl apply -f ../build/secret.yaml -n $(NS)

update:
	helm template vault . > ../build/debug.yaml
	kubectl apply -f ../build/debug.yaml -n $(NS)

cleanup:
	kubectl delete ns $(NS)

watch-events:
	kubectl get events -n $(NS) -w --sort-by=.metadata.creationTimestamp
