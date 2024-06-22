# Variables
IMAGE_NAME = jmdots/comfyui
TAG = latest-nvidia
CONTAINER_NAME = jmdots-comfyui
HOST_PORT = 8188
CONTAINER_PORT = 8188
VOLUME_MODELS = $(pwd)/var/models
VOLUME_CUSTOM_NODES = $(pwd)/var/custom_nodes
BIND_ADDRESS = 127.0.0.1
VERSION ?= latest

.PHONY: build up down restart logs shell nvidia ps rm stop

build:
	docker build -t $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):$(TAG) .

up:
	docker-compose up -d

down:
	docker-compose down

restart: down up

logs:
	docker-compose logs -f

nvidia:
	watch -n 1 nvidia-smi

ps:
	docker-compose ps

rm:
	docker-compose rm -f

shell:
	docker-compose exec $(CONTAINER_NAME) /bin/bash

stop:
	docker-compose stop
