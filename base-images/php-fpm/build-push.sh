#!/bin/bash

export TAG=$1
export PHP_VERSION=$2

docker-compose -f build.yml build --no-cache php-fpm-base
docker push jslim/php${PHP_VERSION}-laravel-base:${TAG}
docker image tag jslim/php${PHP_VERSION}-laravel-base:${TAG} jslim/php${PHP_VERSION}-laravel-base:latest
docker image push jslim/php${PHP_VERSION}-laravel-base:latest
