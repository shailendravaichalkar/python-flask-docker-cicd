#!/bin/sh
########################################
# Author: Shailendra Vaichalkar
#
# Execute this script:  ./deploy_docker.sh <DOCKER_IMAGE>
# Replace the $TAG with the actual Build Tag you want to deploy
#
########################################

set -e

DOCKER_IMAGE=$1
CONTAINER_NAME="python-flask-docker-cicd-demo-poc"
LOCATION="/home/devops/python-flask-docker-cicd"
CERT_PORT="8083:80"
PROD_PORT="8084:80"


# Check for arguments
if [[ $# -lt 1 ]] ; then
    echo '[ERROR] You must supply a Docker Image to pull'
    exit 1
fi

#Change the working location
cd "$LOCATION"

echo "Deploying $CONTAINER_NAME to Docker Container"

#Check for running container & stop it before starting a new one
if [ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}_CERT) = "true" ]; then
    docker stop ${CONTAINER_NAME}_CERT
fi

#Check for running container & stop it before starting a new one
if [ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}_PROD) = "true" ]; then
    docker stop ${CONTAINER_NAME}_PROD
fi

echo "Starting $CONTAINER_NAME using Docker Image name: $DOCKER_IMAGE for CERT"

#CERT
docker run -d --rm=true -p $CERT_PORT  --name ${CONTAINER_NAME}_CERT $DOCKER_IMAGE

echo "Starting $CONTAINER_NAME using Docker Image name: $DOCKER_IMAGE for PROD"

#PROD
docker run -d --rm=true -p $PROD_PORT  --name ${CONTAINER_NAME}_PROD $DOCKER_IMAGE

docker ps -a
