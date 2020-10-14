# up9 Helm chart

This helm chart will install:
 * up9 agent (invokes test runner)
 * up9 auth helper
 * collector + injector (optional - injects sidecars for observing traffic) 
 * Dependencies (service account, cluster role and cluster role binding) in `up9` namespace

## Installation 
Before running the installation commands, please make sure `kubectl` command is configured to control desired Kubernetes cluster

### Set helm values

Update `values.yaml`

#### Required
`clientId` - api key for up9 API
 
`clientSecret` - api key secret for up9 API

`agentName` - choose a name with which the agent registers itself

#### Optional
`sidecarInjectionEnabled` - Whether to enable sidecar injection

### Run helm installation - using HELM v2
To install the chart in default namespace (the "up9" parameter is the folder name containing this helm chart)
```
helm install up9 --name up9agent --namespace default
``` 

### Run helm installation - using HELM v3
To install the chart in default namespace (the "up9" parameter is the folder name containing, "up9agent" is helm deployment name)
```
helm install up9agent up9 --namespace default
``` 

### Verify installation using HELM
List charts installed in `default` namespace
```
helm ls -n default
```

## Uninstall    
```
helm delete --purge up9agent
```


