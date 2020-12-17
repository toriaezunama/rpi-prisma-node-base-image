#!/usr/bin/env bash

USERNAME=

# Push base image to docker hub
#   Notes: 
#    - We have to tag the image with your <username> for hub.docker.com
#    - Don't forget to login `docker login -u <username>`
docker tag prisma-arm32v7:node-14 ${USERNAME}/prisma-arm32v7:node-14
docker push ${USERNAME}/prisma-arm32v7:node-14
