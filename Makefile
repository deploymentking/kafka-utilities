# Makefile for building and pushing kafka-utilities Docker image

# Variables
IMAGE_NAME := deploymentking/kafka-utilities
TAG ?= latest
DOCKER_IMAGE := $(IMAGE_NAME):$(TAG)

# Default target
.DEFAULT_GOAL := help

# Targets
.PHONY: help
help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

.PHONY: build
build: ## Build the Docker image
	@echo "Building Docker image: $(DOCKER_IMAGE)"
	docker build -t $(DOCKER_IMAGE) .
	@echo "Build complete: $(DOCKER_IMAGE)"

.PHONY: tag
tag: ## Tag the Docker image (use TAG=your-tag to specify a custom tag)
	@echo "Tagging image as: $(DOCKER_IMAGE)"
	@if [ "$(TAG)" != "latest" ]; then \
		docker tag $(IMAGE_NAME):latest $(DOCKER_IMAGE); \
		echo "Tagged $(IMAGE_NAME):latest as $(DOCKER_IMAGE)"; \
	else \
		echo "Image already tagged as latest"; \
	fi

.PHONY: push
push: ## Push the Docker image to Docker Hub
	@echo "Pushing Docker image: $(DOCKER_IMAGE)"
	docker push $(DOCKER_IMAGE)
	@echo "Push complete: $(DOCKER_IMAGE)"

.PHONY: all
all: build push ## Build and push the Docker image (equivalent to build + push)
	@echo "All tasks complete"

.PHONY: clean
clean: ## Remove the local Docker image
	@echo "Removing Docker image: $(DOCKER_IMAGE)"
	docker rmi $(DOCKER_IMAGE) || true
	@echo "Clean complete"

.PHONY: test
test: build ## Build and test that the utilities are available
	@echo "Testing kafka utilities..."
	@docker run --rm $(DOCKER_IMAGE) which topicctl
	@docker run --rm $(DOCKER_IMAGE) which kaf
	@docker run --rm $(DOCKER_IMAGE) which kafkactl
	@echo "All utilities are available in the image"
