#!/usr/bin/env bash 

docker build . -t k8sdotfile:latest

echo "**********************************************************************************************************************"
echo "* To use from a docker container:"
echo '*  docker run -it --rm -v ~/.kube:/home/k8sdotfile/.kube --hostname docker-container --entrypoint /bin/bash k8sdotfile'
echo "**********************************************************************************************************************"
