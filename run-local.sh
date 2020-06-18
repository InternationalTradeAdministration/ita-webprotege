#!/usr/bin/env bash

#MongoDB
sudo docker run --name ita-webprotege-db -d -v mongodb_data:/data/db itadevacr.azurecr.io/ita-webprotege/db:latest

#Tomcat
sudo docker run --name webprotege-web -d -v webprotege_data:/data/webprotege -v webprotege_logs:/var/log/webprotege --link ita-webprotege-db -p 8888:8080 itadevacr.azurecr.io/ita-webprotege/web:latest