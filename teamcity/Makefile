include .env
export $(shell sed 's/=.*//' .env)

# current user id
SYSTEM_UID := $(shell id -u)
export SYSTEM_UID

# current docker group id
SYSTEM_DID := $(shell getent group docker | cut -d: -f3)
export SYSTEM_DID

up:
	docker-compose -f docker-compose.yml up -d
stop:
	docker-compose -f docker-compose.yml stop
build:
	docker-compose -f docker-compose.yml build
down:
	docker-compose -f docker-compose.yml down
