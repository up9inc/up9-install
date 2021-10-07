C_Y=\033[1;33m
C_C=\033[0;36m
C_M=\033[0;35m
C_R=\033[0;41m
C_N=\033[0m
SHELL=/bin/bash

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# Variables and lists
BUCKET_PATH="static.up9.io/k8s"
HELM_REPO="https://static.up9.com/helm"
OUTPUT_FILE="up9.K8S.TEMPLATE.yaml"
SUFFIX="$(shell date '+%s')"


tools: 	## check tools availability
	@(helm version --short 2>/dev/null && echo " ->> HELM found, good to go" && echo "") \
        || (echo " ->> Failed to find HELM -- cannot proceed! ")
	@(gsutil version 2>/dev/null && echo " ->> GSUTIL found, good to go" && echo "") \
        || (echo " ->> Failed to find GSUTIL -- cannot proceed! ")
	@(gsutil ls gs://${BUCKET_PATH} 2>/dev/null && echo "" && \
		echo " ->> Successfully accessed GS bucket ${ENV}") \
		|| (echo " ->> Failed to access GS bucket ${ENV} !")


# Actual build and clean tasks
build: ## Build k8s template file from HELM chart
	helm template --repo ${HELM_REPO} up9agent up9 \
		--set clientId=__TMPL_CLIENT_ID__ \
		--set clientSecret=__TMPL_CLIENT_SECRET__ \
		--set agentName=__TMPL_AGENT_NAME__ \
		--set workspace=__TMPL_AGENT_NAME__ > ${OUTPUT_FILE}


clean: ## Clean build artifacts
	@rm -f ${OUTPUT_FILE}

publish: build ## Build and publish k8s template to GCS bucket
	@echo "publishing file ${OUTPUT_FILE} .."
	gsutil mv gs://${BUCKET_PATH}/${OUTPUT_FILE} gs://${BUCKET_PATH}/${OUTPUT_FILE}.${SUFFIX}
	@gsutil cp ${OUTPUT_FILE} gs://${BUCKET_PATH}/${OUTPUT_FILE}

