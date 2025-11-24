FROM node:20-slim

# 安装系统级依赖
RUN apt-get update && apt-get install -y \
    curl git procps \
    && rm -rf /var/lib/apt/lists/*

# 全局安装 Supergateway 和 官方核心 Servers
RUN npm install -g supergateway \
    @modelcontextprotocol/server-filesystem \
    @modelcontextprotocol/server-memory \
    @modelcontextprotocol/server-brave-search

WORKDIR /app

# 默认命令（会被 docker-compose 覆盖）
CMD ["npx", "supergateway", "--help"]