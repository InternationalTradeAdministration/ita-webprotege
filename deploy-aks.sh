#!/usr/bin/env bash

kubectl delete deployment,service,ingress ita-webprotege-web ita-webprotege-db ita-webprotege -n mdsnamespace
kubectl apply -f kube-config-storage.yml -n mdsnamespace
kubectl apply -f kube-config-db.yml -n mdsnamespace
kubectl apply -f kube-config-web.yml -n mdsnamespace
