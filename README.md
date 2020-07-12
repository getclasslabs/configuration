# configuration
All of the configuration needed to run the application environment.


## Minikube

Ref: https://kubernetes.io/docs/tasks/tools/install-minikube/

The driver to be used is Docker, is not necessary to install others drivers.


### Creating a deployment
```bash
# Start minikube
$minikube start --driver=docker

# Install helm
$curl -L https://git.io/get_helm.sh | bash
$helm init

# Create kong inside the cluster
$kubectl create ns kong
$helm install --version 0.26.1 \
--name kong stable/kong \
--namespace kong \
--set ingressController.enabled=true \
--set image.tag=1.4 \
--set admin.useTLS=false

# Export some addresses
export PROXY_ADDR=$(minikube service -n kong kong-kong-proxy --url | head -1)
export ADMIN_ADDR=$(minikube service -n kong kong-kong-admin --url | head -1)

# Test it:
curl -i $PROXY_ADDR

#Creating Konga
kubectl create -f konga/deployment.yaml
export KONGA_ADDR=$(minikube service -n kong konga-svc --url | head -1)

#To setup kong, just enter in KONGA_ADDR, in the configuration screen, put the ADMIN_ADDR

```


//kubectl expose deployment user --type=NodePort --name=user-svc --target-port=8080

