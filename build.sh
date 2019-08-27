#!/usr/bin/env bash

#az login
sudo az acr login --name ITAContainerRegistry
sudo docker login ITAContainerRegistry.azurecr.io
sudo docker build -t ITAContainerRegistry.azurecr.io/ita-webprotege/web .
sudo docker push ITAContainerRegistry.azurecr.io/ita-webprotege/web

sudo docker pull mongo:3
sudo docker tag mongo:3 ITAContainerRegistry.azurecr.io/ita-webprotege/db
sudo docker push ITAContainerRegistry.azurecr.io/ita-webprotege/db


