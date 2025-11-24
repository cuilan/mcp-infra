#!/bin/bash
# 用法: ./scripts/manage.sh [start|stop|logs|restart]

COMMAND=$1

# 确保使用 Lima 的 Context
export DOCKER_CONTEXT=lima

case $COMMAND in
  start)
    echo "🚀 Starting MCP Infrastructure..."
    docker-compose up -d
    echo "✅ Services are running."
    echo "   - Filesystem MCP: http://localhost:8080/sse"
    ;;
  stop)
    echo "🛑 Stopping services..."
    docker-compose down
    ;;
  logs)
    docker-compose logs -f
    ;;
  update)
    echo "🔄 Rebuilding images..."
    docker-compose build --no-cache
    docker-compose up -d
    ;;
  *)
    echo "Usage: $0 {start|stop|logs|update}"
    exit 1
esac