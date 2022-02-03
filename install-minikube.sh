#!/usr/bin/env bash

sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && sudo chmod +x minikube

sudo mv minikube /usr/local/bin/
\
minikube version

# Start a cluster using the docker driver:

minikube start --driver=docker

# To make docker the default driver:

minikube config set driver docker

# to affect delete and start minikube

minikube delete

minikube start
:
