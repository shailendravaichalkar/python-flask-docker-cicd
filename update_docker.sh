#!/bin/sh
########################################
# Author: Shailendra Vaichalkar
# 
# Execute this script:  ./update_docker.sh <IMAGE> <TAG>
#
########################################

set -e

DOCKER_IMAGE=$1
BUILD_ID=$2
LOCATION="python-flask-docker-cicd"

# Check for arguments
if [[ $# -lt 2 ]] ; then
    echo '[ERROR] You must supply a Docker Image Name and Tag to build'
    exit 1
fi

# Change the working location
cd "$LOCATION"

#Get the latest code
git pull origin master

#Build the image with latest code
docker build -t ${DOCKER_IMAGE}:${BUILD_ID} .

#Tag "latest" for the recent update image 
docker tag ${DOCKER_IMAGE}:${BUILD_ID} ${DOCKER_IMAGE}:latest

#Push code to docker hub
docker push ${DOCKER_IMAGE}:${BUILD_ID}
docker push ${DOCKER_IMAGE}:latest


