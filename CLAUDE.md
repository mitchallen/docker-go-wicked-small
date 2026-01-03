# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a minimal example demonstrating how to create the smallest possible Docker image for a Go application using a multi-stage build with a `scratch` base image.

## Build and Run Commands

```sh
# Build the Docker image
docker build -t tiny-go .

# Run the container
docker run --rm tiny-go

# Check image size
docker images | grep tiny-go
```

## Architecture

The Dockerfile uses a two-stage build:
1. **Build stage**: Uses `golang:1.22` to compile the Go code into a static binary with `CGO_ENABLED=0` and stripped symbols (`-ldflags="-s -w"`)
2. **Runtime stage**: Uses `scratch` (empty image) containing only the compiled binary

The Go source code is embedded directly in the Dockerfile rather than copied from the host filesystem.

## HTTPS Variant

For applications requiring HTTPS/TLS, replace the runtime stage with `gcr.io/distroless/static` which includes root certificates.
