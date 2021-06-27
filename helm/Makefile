C_Y=\033[1;33m
C_C=\033[0;36m
C_M=\033[0;35m
C_N=\033[0m
SHELL=/bin/bash

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help build

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

BUCKET_MASTER="gs://static.up9.io/helm/"
BUCKET_DEVELOP="gs://static.up9.io/helm-develop/"
BUCKET:=${BUCKET_DEVELOP}

CPLOG="/tmp/cp.$$$$.log"

CHARTNAME="up9agent"

clean:	## remove build artifacts
	@echo Cleaning files: 
	@(ls -l ./build 2>/dev/null || echo "")
	@rm -rf build
	@echo Done.


build:  test ## build Helm repo artifacts
	mkdir -p ./build
	cd build && helm package ../up9 && helm repo index . && ls -l

publish:  publish-develop ## publish Helm chart - copy to public bucket

publish-develop:	build 	## publish Helm chart to DEVELOP repo - https://static.up9.com/helm-develop
	@cd build && \
		gsutil cp -c -L $(CPLOG) -r . $(BUCKET_DEVELOP) && \
		gsutil setmeta -r -h "Cache-Control:public, max-age=30" $(BUCKET_DEVELOP) ; \
		echo -e "\nSee operation log in ${C_Y} ${CPLOG} ${C_N}"


publish-master:		build 	## publish Helm chart to MASTER repo - https://static.up9.com/helm
	@cd build && \
		gsutil cp -c -L /tmp/cp.$$.log -r . $(BUCKET_MASTER) && \
		gsutil setmeta -r -h "Cache-Control:public, max-age=30" $(BUCKET_MASTER)

test: ## test bucket connection and tooling
	@echo -e "Verifying connection and tooling\n"
	@(gsutil ls ${BUCKET} 2>/dev/null && \
		echo -e "\n ${C_C} Succefully accessed bucket ${C_Y} ${BUCKET} ${C_N}") \
	|| (echo -e "\n ${C_R} Failed ${C_N} to access bucket ${C_Y} ${BUCKET} ${C_N}! ")
	@(helm version | grep -o v3 >/dev/null && echo -e "  Will use ${C_Y} helm ${C_N} for build" ) \
		|| (echo -e "\n ${C_R} Incompatible or missing ${C_Y} helm ${C_N} -- cannot build! ")
	@echo ""

