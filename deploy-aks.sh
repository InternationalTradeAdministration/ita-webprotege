#!/usr/bin/env bash

kubectl delete deployment,service,ingress ita-webprotege-web ita-webprotege-db ita-webprotege -n mdsnamespace
kubectl apply -f kube-config.yml -n mdsnamespace
