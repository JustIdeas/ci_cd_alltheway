#!/bin/bash
#removendo container anterior
docker rm -f /jenkins
#Iniciando jenkins
docker run \
  --name jenkins \
  --restart=on-failure \
  --detach \
  --publish 53400:8080 \
  --publish 53500:50000 \
  test-case-jenkins:0.0.1 
