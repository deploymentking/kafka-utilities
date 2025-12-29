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

## Automated Releases

This repository uses [Semantic Release](https://semantic-release.gitbook.io/) with [Conventional Commits](https://www.conventionalcommits.org/) to automatically version and release Docker images.

### How It Works

1. **Commit with conventional format** to the `main` branch
2. **GitHub Actions** automatically analyzes your commits
3. **Semantic version** is determined based on commit types
4. **Docker image** is built and pushed with version tags

### Commit Format

Use conventional commit messages to trigger releases:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Common types:**
- `feat:` - New feature (triggers minor version bump, e.g., 1.0.0 → 1.1.0)
- `fix:` - Bug fix (triggers patch version bump, e.g., 1.0.0 → 1.0.1)
- `docs:` - Documentation changes (triggers patch version bump)
- `refactor:` - Code refactoring (triggers patch version bump)
- `perf:` - Performance improvements (triggers patch version bump)
- `chore:` - Maintenance tasks (no release)
- `ci:` - CI/CD changes (no release)
- `test:` - Test changes (no release)

**Breaking changes** (triggers major version bump, e.g., 1.0.0 → 2.0.0):
```
feat!: remove legacy API

BREAKING CHANGE: The old API has been removed
```

### Examples

```bash
# Patch release (1.0.0 → 1.0.1)
git commit -m "fix: resolve connection timeout issue"

# Minor release (1.0.0 → 1.1.0)
git commit -m "feat: add support for SSL connections"

# Major release (1.0.0 → 2.0.0)
git commit -m "feat!: redesign CLI interface

BREAKING CHANGE: Command structure has changed"
```

### Required Secrets

To enable automated releases, configure these secrets in your GitHub repository:
- `DOCKER_USERNAME` - Your Docker Hub username
- `DOCKER_PASSWORD` - Your Docker Hub access token

### Available Image Tags

After a release, Docker images are tagged as:
- `deploymentking/kafka-utilities:latest` - Always points to the latest release
- `deploymentking/kafka-utilities:1.2.3` - Specific semantic version

