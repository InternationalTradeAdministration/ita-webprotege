#!/usr/bin/env bash

#MongoDB
sudo docker run --name ita-webprotege-db -d -v mongodb_data:/data/db dataservices.azurecr.io/ita-webprotege/db:latest

#Tomcat
sudo docker run --name webprotege-web -d -v webprotege_data:/data/webprotege -v webprotege_logs:/var/log/webprotege --link ita-webprotege-db -p 80:8080 dataservices.azurecr.io/ita-webprotege/web:latest