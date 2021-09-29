# up9 Helm chart

This helm chart will install:
 * up9-agent (controlling test runners)
 * up9-auth-helper
 * up9-collector (controls traffic tappers / observers)
 * up9-injector (k8s admission controller - injects sidecars for observing application traffic) 
 * Dependencies (service account, role, role binding, cluster role and cluster role binding) in `up9` namespace

# Installation 
Before running the installation commands, please make sure `kubectl` command is configured to control desired Kubernetes cluster

## Set helm values

Prepare `setup.yaml` file with few settings, specific to your installation

### Required
`clientId` - API key for UP9 API
 
`clientSecret` - api key secret for up9 API

`agentName` - choose a name with which the agent registers itself

### Optional

`logging.disableStdoutLogging` - disable logging to stdout (default: 0, logging enabled)
`logging.disableStderrLogging` - disable logging to stderr (default: 0, logging enabled))

`sidecarInjectionEnabled` - Whether to enable sidecar injection

## Run helm (v3) installation
To install the chart in default namespace (the "up9" parameter is the folder name containing, "up9agent" is helm deployment name)
```
helm install up9agent up9 --namespace default -f setup.yaml
``` 

To install the chart from UP9 Helm repo - use the following command:
```
helm install --repo https://static.up9.com/helm/ up9agent up9 --namespace default -f setup.yaml
```

## Verify installation using HELM
List charts installed in `default` namespace
```
helm -n default ls
```

## Uninstall    
```
helm -n default delete up9agent
```

## Example setup.yaml file
The example below will use `up9xyz` name for installed UP9 agent and disable logging to stdout

```
agentName: up9xyz
clientId: dGhpcyBpcyBjbGllbnRJZAo=
clientSecret: dGhpcyBpcyBjbGllbnRTZWNyZXQK
logging:
  disableStdoutLogging: 1
```
