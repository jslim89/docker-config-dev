#!/bin/bash

export TAG=$1

docker-compose -f build.yml build --no-cache php-fpm-base
docker push jslim/php8-laravel-base:${TAG}
docker image tag jslim/php8-laravel-base:${TAG} jslim/php8-laravel-base:latest
docker image push jslim/php8-laravel-base:latest
