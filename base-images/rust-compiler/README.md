# Rust compiler

Base image for Rust to compile into different architecture

## Usage

Refers to
[docker-compose-example-usage.yml](./docker-compose-example-usage.yml), there
are some example for different architectures

```sh
docker-compose -f docker-compose-example-usage.yml up build-linux-amd64
docker-compose -f docker-compose-example-usage.yml up build-linux-arm64
docker-compose -f docker-compose-example-usage.yml up build-alpine-amd64
docker-compose -f docker-compose-example-usage.yml up build-alpine-arm64
docker-compose -f docker-compose-example-usage.yml up build-windows-amd64 # This is not working for now
docker-compose -f docker-compose-example-usage.yml up build-windows-arm64
```

