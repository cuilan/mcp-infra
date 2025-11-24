# mcp-infra

mcp-infra/
├── .env.example              # 环境变量模板 (API Keys, DB密码) - 不要提交 .env!
├── .gitignore                # 忽略文件列表
├── README.md                 # 项目说明与架构图
├── docker-compose.yml        # 核心编排文件
│
├── images/                   # 自定义 Docker 镜像构建
│   ├── gateway/              # 通用 MCP Gateway 镜像 (Node + Supergateway)
│   │   └── Dockerfile
│   └── python-env/           # 如果你需要跑 Python 类的 MCP Server
│       └── Dockerfile
│
├── servers/                  # 各个 MCP Server 的具体配置或挂载数据
│   ├── filesystem/           # 文件系统 Server 数据挂载点
│   │   └── data/             # (被 gitignore 忽略，仅做目录占位)
│   └── postgres/             # 数据库初始化脚本
│       └── init.sql
│
├── config/                   # 客户端配置文件备份/模板
│   ├── cursor_mcp.json       # Cursor 的 MCP 配置片段
│   └── vscode_mcp.json       # VS Code 的 MCP 配置片段
│
├── scripts/                  # 维护脚本
│   ├── start.sh              # 启动服务
│   ├── update-images.sh      # 更新基础镜像
│   └── connect-cursor.sh     # (可选) 快速打印 SSE 连接地址
│
└── docs/                     # 你的知识库
    ├── architecture.md       # 架构说明
    └── troubleshooting.md    # 常见问题 (比如 Lima 网络不通怎么办)