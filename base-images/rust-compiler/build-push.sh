#!/bin/bash

docker buildx create --name multiarch --use --bootstrap

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t jslim/rust-compiler:1.92-trixie \
  --push \
  -f Dockerfile \
  .

