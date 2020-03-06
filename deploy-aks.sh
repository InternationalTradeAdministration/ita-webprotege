#!/usr/bin/env bash

#az aks get-credentials --resource-group ITA --name ITAKube

kubectl apply -f kube-config.yml

#az aks browse --resource-group ITA --name ITAKube 