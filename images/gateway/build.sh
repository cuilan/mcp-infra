#!/bin/bash
set -e

IMAGE_NAME="mcp-infra/gateway:latest"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔨 Building $IMAGE_NAME..."
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"

echo "✅ Build complete: $IMAGE_NAME"

