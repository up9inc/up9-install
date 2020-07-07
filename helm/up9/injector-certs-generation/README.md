# TLS Generator

This is stuff useful for new users who need to generate a new TLS cert for deploying the sidecar injector.

The important thing here

```ini
[alt_names]
DNS.1   = <SERVICE_NAME>
DNS.2   = <SERVICE_NAME>.<NAMESPACE>
DNS.3   = <SERVICE_NAME>.<NAMESPACE>.svc
```


`DEPLOYMENT=us-east-1 CLUSTER=PRODUCTION ./new-cluster-injector-cert.rb`

`cd us-east-1/PRODUCTION`

`kubectl create secret generic k8s-sidecar-injector --from-file=sidecar-injector.crt --from-file=sidecar-injector.key --dry-run -o yaml`

The committed files are the ones that used to generate the current values
