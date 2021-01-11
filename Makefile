.PHONY: pack index do-index update-ghpages

HELMREPO_SRC?=../helmrepo/
MAIN_BRANCH?=main

pack:
	helm package $(HELMREPO_SRC)/couchdb
	helm package $(HELMREPO_SRC)/vault

COMMIT_MSG?="New repo items"
index: | pack do-index update-ghpages

do-index:
	helm repo index .

update-ghpages:
	git checkout --orphan new-ghpages
	git add .
	git commit -m $(COMMIT_MSG)
	git checkout gh-pages
	git reset --hard new-ghpages
	echo "Now push!"
