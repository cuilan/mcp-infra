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
    # 注意：@modelcontextprotocol/server-git 暂未发布到 npm
    # @modelcontextprotocol/server-github 是可用的，如果需要可以取消注释
    # @modelcontextprotocol/server-github

WORKDIR /app

# 默认命令（会被 docker-compose 覆盖）
CMD ["npx", "supergateway", "--help"]