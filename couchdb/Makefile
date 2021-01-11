.PHONY: create cleanup update watch-events

NS?=couchdb-test
ADMIN_USERNAME?=admin
ADMIN_PASSWORD?=admin

.SILENT: .secret.yaml
secret.yaml:
	kubectl create secret generic couchdb --from-literal=adminUsername=$(ADMIN_USERNAME) --from-literal=adminPassword=$(ADMIN_PASSWORD) --dry-run=client -o yaml > ../build/secret.yaml

create: secret.yaml
	kubectl create ns $(NS) --dry-run=client -o yaml > ../build/ns.yaml
	kubectl apply -f ../build/ns.yaml
	kubectl apply -f ../build/secret.yaml -n $(NS)

update:
	helm template couchdb . > ../build/debug.yaml
	kubectl apply -f ../build/debug.yaml -n $(NS)

cleanup:
	kubectl delete ns $(NS)

watch-events:
	kubectl get events -n $(NS) -w --sort-by=.metadata.creationTimestamp
