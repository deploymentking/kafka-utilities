# kafka-utilities

A Docker image containing Go-based Kafka CLI tools: topicctl, kaf, and kafkactl

## Tools Included

- **topicctl**: Tool for declarative management of Kafka topics
- **kaf**: Modern CLI for Apache Kafka
- **kafkactl**: Command-line interface for Apache Kafka

## Usage

### Using the Docker Image

Pull and run the image from Docker Hub:

```bash
docker pull deploymentking/kafka-utilities:latest
docker run -it deploymentking/kafka-utilities:latest /bin/sh
```

Or run individual tools directly:

```bash
docker run --rm deploymentking/kafka-utilities:latest kaf --help
docker run --rm deploymentking/kafka-utilities:latest kafkactl --help
docker run --rm deploymentking/kafka-utilities:latest topicctl --help
```

### Building the Image

The repository includes a Makefile for building, tagging, and pushing the Docker image:

```bash
# Build the Docker image
make build

# Build and push the image
make all

# Build with a custom tag
make build TAG=v1.0.0

# Push a specific tag
make push TAG=v1.0.0

# Test that utilities are available in the image
make test

# Show all available commands
make help
```

### Available Make Targets

- `make build` - Build the Docker image
- `make push` - Push the Docker image to Docker Hub
- `make all` - Build and push the image
- `make tag` - Tag the Docker image (use TAG=your-tag to specify)
- `make test` - Verify that all utilities are present in the image
- `make clean` - Remove the local Docker image
- `make help` - Display available commands

## Dockerfile

The Dockerfile uses a multi-stage build process:
1. Builder stage: Uses `golang:alpine` to install the Kafka utilities
2. Final stage: Uses `alpine:latest` with curl, jq, and bash, copying only the compiled binaries

