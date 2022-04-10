PROJECT_NAME=latex

UID := $(shell id -u)
USER := $(shell id -un)
GID := $(shell id -g)
GROUP := $(shell id -gn)
export UID
export USER
export GID
export GROUP

up:
	docker-compose -p $(PROJECT_NAME) up -d --build

down:
	docker-compose -p ${PROJECT_NAME} down --remove-orphans

