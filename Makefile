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
	docker run --gpus all -d \
		--name $(CONTAINER_NAME) \
		-p $(BIND_ADDRESS):$(HOST_PORT):$(CONTAINER_PORT) \
		-v $(VOLUME_MODELS):/workspace/models \
		-v $(VOLUME_CUSTOM_NODES):/workspace/ComfyUI/custom_nodes \
		$(IMAGE_NAME):$(VERSION)

down:
	docker stop $(CONTAINER_NAME) && \
	docker rm $(CONTAINER_NAME)

restart: down up

logs:
	docker logs -f $(CONTAINER_NAME)

nvidia:
	watch -n 1 nvidia-smi

ps:
	docker ps

rm:
	docker rm -f $(CONTAINER_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) /bin/bash

stop:
	docker stop $(CONTAINER_NAME)
