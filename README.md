# MCP 基础设施管理平台

> 模块化的 Model Context Protocol (MCP) 服务管理平台

[![架构版本](https://img.shields.io/badge/架构-v2.0-blue)](./mcp)
[![License](https://img.shields.io/badge/license-MIT-green)](./LICENSE)

## ✨ 特性

- 🚀 **模块化设计**：每个服务独立管理，互不干扰
- 🎯 **统一管理**：`mcp` 命令行工具统一管理所有服务
- 📦 **通用镜像**：基于 `node:20` 的通用 Gateway 镜像，内置常用 MCP Servers
- 🔧 **易于扩展**：只需编写简单的 docker-compose 文件即可添加新服务
- 🐳 **Docker 化**：完全容器化，环境一致
- 🌐 **网络隔离**：独立网络，安全可靠

## 🚀 快速开始

### 前置要求

- Docker 20.10+
- Docker Compose 2.0+
- Bash 4.0+（macOS/Linux）

### 安装

```bash
# 克隆项目
git clone https://github.com/yourusername/mcp-infra.git
cd mcp-infra

# 复制环境变量模板
cp .env.example .env

# 编辑配置（如修改端口）
vim .env

# 添加执行权限
chmod +x mcp

# 创建 Docker 网络
./mcp network

# 构建基础镜像
./mcp build gateway

# 启动所有服务
./mcp start
```

### 验证安装

```bash
# 查看服务状态
./mcp status

# 查看所有可用服务
./mcp list

# 查看日志
./mcp logs
```

## 📖 使用指南

### 基本命令

```bash
# 构建镜像（必须指定镜像名）
./mcp build gateway

# 启动服务
./mcp start                    # 启动所有服务
./mcp start filesystem         # 启动指定服务
./mcp start filesystem obsidian # 启动多个服务

# 停止服务
./mcp stop                     # 停止所有服务
./mcp stop obsidian            # 停止指定服务

# 重启服务
./mcp restart filesystem       # 重启指定服务

# 查看状态和日志
./mcp status                   # 查看服务状态
./mcp ps                       # 查看容器列表
./mcp logs filesystem          # 查看服务日志
./mcp logs                     # 查看所有日志

# 维护
./mcp clean                    # 清理未使用的容器和镜像
./mcp list                     # 列出所有可用服务和镜像

# 帮助
./mcp help                     # 显示帮助信息
```

## 🗂️ 项目结构

```
mcp-infra/
├── mcp                              # 🔧 服务管理脚本（核心入口）
│
├── services/                        # 服务定义目录
│   ├── filesystem/                  # 文件系统服务
│   │   └── docker-compose.yaml
│   ├── obsidian/                    # Obsidian 服务
│   │   └── docker-compose.yaml
│   └── postgres/                    # PostgreSQL 服务
│       └── docker-compose.yaml
│
├── images/                          # Docker 镜像定义
│   ├── gateway/                     # 通用网关镜像（核心）
│   │   ├── Dockerfile
│   │   └── build.sh                 # 构建脚本
│   └── ...
│
├── .env.example                     # 环境变量模板
├── .gitignore                       # Git 忽略列表
│
└── config/                          # 客户端配置示例
    ├── cursor_mcp.json              # Cursor 配置
    └── vscode_mcp.json              # VS Code 配置
```

## 🎛️ 可用服务

| 服务名 | 端口 | 说明 | 实现方式 |
|--------|------|------|----------|
| **filesystem** | 8080 | 文件系统访问服务 | `@modelcontextprotocol/server-filesystem` |
| **obsidian** | 8082 | Obsidian 笔记管理 | 直接挂载 Vault + `server-filesystem` |
| **postgres** | 8081 | PostgreSQL 数据库访问 | `@modelcontextprotocol/server-postgresql` |

## ➕ 添加新服务

1.  在 `services/` 下创建新目录（如 `myservice`）。
2.  创建 `docker-compose.yaml`，使用 `mcp-infra/gateway:latest` 镜像。
3.  在 `mcp` 脚本的 `SERVICES` 数组中注册新服务。
4.  在 `.env` 中添加端口配置。

```bash
# mcp 脚本配置示例
SERVICES=(
    ...
    "myservice:services/myservice/docker-compose.yaml:我的新服务"
)
```

## 🔧 配置

### 环境变量

复制 `.env.example` 为 `.env` 并配置：

```bash
# 文件系统服务
MCP_FS_PORT=8080

# Obsidian 服务
MCP_OBSIDIAN_PORT=8082

# PostgreSQL 服务
MCP_PG_PORT=8081
DATABASE_URL=postgresql://user:pass@host:5432/db
```

### 客户端配置 (Cursor)

创建或编辑 `.cursor/mcp.json`：

```json
{
  "mcpServers": {
    "filesystem": {
      "url": "http://localhost:8080/sse"
    },
    "obsidian": {
      "url": "http://localhost:8082/sse"
    }
  }
}
```

## 🛠️ 核心组件说明

### Gateway 镜像

`images/gateway/Dockerfile` 是项目的核心，预装了：
- `supergateway`: 将 stdio 转换为 SSE
- `@modelcontextprotocol/server-filesystem`
- `@modelcontextprotocol/server-memory`
- `@modelcontextprotocol/server-brave-search`
- `@modelcontextprotocol/server-github` (可选)

## 📝 更新日志

### v2.1.0 (2024-11-26)

- ✨ **架构升级**：分离构建与运行逻辑
- 🚀 **独立构建**：`images/*/build.sh` 独立管理镜像构建
- 📂 **服务归档**：所有服务配置移至 `services/` 目录
- 🔄 **Obsidian 优化**：改用原生 `server-filesystem` 方案，移除复杂中间件

### v2.0.0 (2024-11-26)

- ✨ 重构为模块化架构
- ✨ 新增 `mcp` 命令行工具

## 📄 License

MIT License - 详见 [LICENSE](./LICENSE)

---

**维护者**: [@yourusername](https://github.com/yourusername)  
**最后更新**: 2024-11-26
