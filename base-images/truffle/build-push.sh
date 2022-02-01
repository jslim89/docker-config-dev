#!/bin/bash

export TAG=$1
export NODE_VERSION=$2

docker-compose -f build.yml build --no-cache node17-truffle
docker push jslim/node${NODE_VERSION}-truffle:${TAG}
docker image tag jslim/node${NODE_VERSION}-truffle:${TAG} jslim/node${NODE_VERSION}-truffle:latest
docker image push jslim/node${NODE_VERSION}-truffle:latest
