C_Y=\033[1;33m
C_C=\033[0;36m
C_M=\033[0;35m
C_N=\033[0m
SHELL=/bin/bash

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFA

AULT_GOAL := help

BUCKET_MASTER=gs://static.up9.com/helm/
BUCKET_DEVELOP=www.up9.io
#ENV=${ENV_PROD}
ENV:=${ENV_PREVIEW}

clean:	## remove build artifacts
	@echo Cleaning files .. 
	@ls -l *.tgz index.yaml

build:  ## Deploy all services to Kubernetes cluster
	@kubectl -n trdemo get svc,pods,deploy -o wide

publish:  ## Run all services as dockers

