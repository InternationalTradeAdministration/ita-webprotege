#!/usr/bin/env bash

sudo docker login $AZURE_CONTAINER_USER.azurecr.io -u $AZURE_CONTAINER_USER -p $AZURE_CONTAINER_KEY  #use container username and access key
sudo docker-compose build
sudo docker-compose push