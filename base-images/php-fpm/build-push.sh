#!/bin/bash

export TAG=$1

docker-compose -f build.yml build --no-cache php-fpm-laravel
docker push jslim/php-fpm-laravel:${TAG}
docker image tag jslim/php-fpm-laravel:${TAG} jslim/php-fpm-laravel:latest
docker image push jslim/php-fpm-laravel:latest
