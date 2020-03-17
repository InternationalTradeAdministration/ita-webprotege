#!/usr/bin/env bash

#az login
sudo az acr login --name dataservices
sudo docker login dataservices.azurecr.io -u dataservices -p $AZURE_CONTAINER_KEY  #use container username and access key
sudo docker build -t dataservices.azurecr.io/ita-webprotege/web .
sudo docker push dataservices.azurecr.io/ita-webprotege/web:latest

sudo docker pull mongo:3
sudo docker tag mongo:3 dataservices.azurecr.io/ita-webprotege/db
sudo docker push dataservices.azurecr.io/ita-webprotege/db:latest

kubectl delete deployment,service ita-webprotege-web ita-webprotege-db -n webprotege
kubectl delete ingress ita-webprotege -n webprotege
sleep 10 #may need to wait longer...

# kubectl apply -f kube-cluster-issuer.yml
# kubectl apply -f kube-certificate.yml
kubectl apply -f kube-config.yml
