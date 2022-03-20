#!/bin/bash

export TAG=$1

docker-compose -f build.yml build --no-cache python-brownie
docker push jslim/python-brownie:${TAG}
docker image tag jslim/python-brownie:${TAG} jslim/python-brownie:latest
docker image push jslim/python-brownie:latest
