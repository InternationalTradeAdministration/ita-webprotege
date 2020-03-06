#!/usr/bin/env bash

#az login
sudo az acr login --name dataservices
sudo docker login dataservices.azurecr.io -u dataservices -p $AZURE_CONTAINER_KEY  #use container username and access key
sudo docker build -t dataservices.azurecr.io/ita-webprotege/web .
sudo docker push dataservices.azurecr.io/ita-webprotege/web:latest

sudo docker pull mongo:3
sudo docker tag mongo:3 dataservices.azurecr.io/ita-webprotege/db
sudo docker push dataservices.azurecr.io/ita-webprotege/db:latest

kubectl delete pod,service ita-webprotege-web ita-webprotege-db
kubectl apply -f kube-config.yml
