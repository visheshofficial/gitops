# Kind cluster setup

## Setup cluster

```bash
kind create cluster --config 1-kind-cluster/kind-cluster-1.yaml
kubectl label node kind-cluster-1-control-plane node.kubernetes.io/exclude-from-external-load-balancers-
```

## Get cluster info

```bash
kubectl cluster-info --context kind-kind-cluster-1
```

## Delete cluster

```bash
kind delete cluster -n kind-cluster-1
```

## Kind Loadbalancer

### Install cloud-provider-kind

- Install cloud-provider-kind
<https://kind.sigs.k8s.io/docs/user/loadbalancer/>

  ```bash
  go install sigs.k8s.io/cloud-provider-kind@latest
  sudo install ~/go/bin/cloud-provider-kind /usr/local/bin
  ```

- Start Service

```bash
  kubectl label node kind-control-plane node.kubernetes.io/exclude-from-external-load-balancers-
  sudo cloud-provider-kind
```

## Creating a Example Service and exposing it via a LoadBalancer

```bash
kubectl apply -f 1-kind-cluster/examples/loadbalancer_etp_local.yaml

❯ k get pod   
NAME                           READY   STATUS    RESTARTS   AGE
policy-local-bb8ff4d7d-2h5pm   1/1     Running   0          45s
policy-local-bb8ff4d7d-n7lq2   1/1     Running   0          45s

curl 172.18.0.5:80/hostname
policy-local-bb8ff4d7d-n7lq2%  

curl 172.18.0.5:80/hostname
policy-local-bb8ff4d7d-2h5pm%  

kubectl delete -f 1-kind-cluster/examples/loadbalancer_etp_local.yaml
```

##

```bash
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
```
