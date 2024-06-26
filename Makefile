# Export variables from .env or .env.example
ifneq (,$(wildcard ./.env))
    include .env
else ifneq (,$(wildcard ./.env.example))
    include .env.example
endif
export

.PHONY: help setup-permissions build rebuild up down restart stop logs ps rm shell nvidia manager

# Default target
.DEFAULT_GOAL := help

# Display this help message
help: ## Display this help message
	@echo "Usage: make [target]"; \
	echo ""; \
	echo "Available targets:"; \
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed -e 's/:/ /' | awk 'BEGIN {FS = " "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Setup permissions for non-root access
setup-permissions: ## Setup permissions for non-root access
	if [ -d "var" ]; then sudo chown -R $(USER):$(USER) var; fi

# Build and rebuild
build: setup-permissions ## Build the Docker image
	docker build -t $(COMFYUI_IMAGE_NAME):$(COMFYUI_TAG) .

rebuild: build restart ## Rebuild the Docker image and restart the containers

# Docker Compose operations
up: ## Start the Docker containers
	docker-compose up -d

down: ## Stop and remove the Docker containers
	docker-compose down --remove-orphans

restart: down up ## Restart the Docker containers

stop: ## Stop the Docker containers
	docker-compose stop

# Logs and monitoring
logs: ## Follow the logs of the Docker containers
	docker-compose logs -f

ps: ## List the Docker containers
	docker-compose ps

rm: ## Remove the Docker containers
	docker-compose rm -f

# Shell access
shell: ## Open a shell in the running Docker container
	docker-compose exec $(COMFYUI_CONTAINER_NAME) /bin/bash

# NVIDIA monitoring
nvidia: ## Monitor NVIDIA GPU usage
	watch -n 1 nvidia-smi

# Manager
manager: setup-permissions ## Clone or update ComfyUI-Manager
	@if [ -d $(COMFYUI_CUSTOM_NODES_DIR) ]; then \
		echo "Updating ComfyUI-Manager..."; \
		cd $(COMFYUI_CUSTOM_NODES_DIR) && git pull; \
	else \
		echo "Cloning ComfyUI-Manager..."; \
		git clone $(COMFYUI_MANAGER_REPO) $(COMFYUI_CUSTOM_NODES_DIR); \
	fi
