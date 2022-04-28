# minikube installation steps
```
!#/usr/bin/env bash

sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && sudo chmod +x minikube

sudo mv minikube /usr/local/bin/
\
minikube version

# Start a cluster using the docker driver:

minikube start --driver=docker

# To make docker the default driver:

minikube config set driver docker

```
# view minikube status

```
minikube status
```
# view node status on minikube
```
kubectl get nodes
```

# view kubernetes version
```
kubectl version
```
# view status of the pod
```
kubectl get pods
```

# view services in kubernetes
```
kubectl get services
```
# create deployment in kubernetes
```
kubectl create deployment nginx-deply --image=nginx
```
# view deployment
```
kubectl get deployment
```
# view replicaset
```
kubectl get replicaset
```
# view pod

```
kubectl get pod
```
# edit deployment change image version
```
kubectl edit deployment nginx-deploy
```

# view logs of container
```
kubectl get pods
```
```
NAME                            READY   STATUS              RESTARTS   AGE
mongo-deploy-69cbc9dbf8-ncgjt   0/1     ContainerCreating   0          47s
nginx-deploy-665b89fb4b-hf8l2   1/1     Running             0          13m
```
```
kubectl logs mongo-deploy-69cbc9dbf8-ncgjt
```
# view detailed information of pod
```
kubectl describe pod mongo-deploy-69cbc9dbf8-ncgjt
```

# login container in kubernetes
```
kubectl exec -it mongo-deploy-69cbc9dbf8-ncgjt -- /bin/bash
```

# Delete Deployment
```
kubectl delete deployment mongo-deploy
```


