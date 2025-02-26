# ArgoCD Bootstrapping

## Deploy Argo-cd using helm

```bash
cd 2-argocd-install-using-helm-and-tf
terraform init
terraform apply -var "KIND_GH_CLIENT_ID=$KIND_GH_CLIENT_ID" -var "KIND_GH_CLIENT_SECRET=$KIND_GH_CLIENT_SECRET" -auto-approve
```

## Check installation

### Helm checks

```bash
 # list helm charts
 helm list -A
 # get notes from the chart
 helm get notes argocd -n argocd
 # get values supplied during installation.
 helm get values argocd -n argocd
 # Get all values
 helm get values argocd -n argocd --all > current-all-values.yaml
 helm show values argo-cd/argo-cd > default-all-values.yaml

 # Get manifest
 helm get manifest argocd -n argocd > manifest.yaml
 # 
 helm history argocd -n argocd 
```

### K8S checks

```bash
kubectl get pods -n argocd
```

## Accesing Argocd UI

```bash
# Port forwarding for accesing locally
kubectl port-forward svc/argo-cd-local-argocd-server -n argocd 8080:443
# https://localhost:8080/

# Get admin credentials
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## Load Balancer Deployment

### Accesing UI uisng URL

- this one is not correct. don't map URL to localhost as we are using LoadBalancer IP
  - <https://argocd.upandrunning.local:8080/> == <https://127.0.0.1:8080/>

- Put the IP of load balancer in the host file.
  - 172.18.0.5 argocd.upandrunning.local

###

curl -k -H "Content-Type: application/json" \
     <https://argocd.upandrunning.local/api/v1/session> \
     -d '{"username":"admin","password":"8hESwAhE9re?+rlCU=ow"}'

## Github SSO

 tf apply -var "KIND_GH_CLIENT_ID=$KIND_GH_CLIENT_ID" -var "KIND_GH_CLIENT_SECRET=$KIND_GH_CLIENT_SECRET"

## Github Repo Creds creation

envsubst < repo-cred.yaml| kubectl apply -f -
