+++
title = 'Openclaw_operation'
date = 2026-03-08T13:03:30+08:00
draft = true
slug = "41768eb"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# Openclaw Operation

### 操作命令

#### 1. Quick Start

- openclaw gateway start 
- openclaw gatewat restart
- openclaw dashboard
- /reasoning on
- /reasoning off
- 



#### 2. Openclaw Security Audit

- **openclaw security audit** 
- **openclaw security audit --deep** 
- **openclaw security audit --fix** 
- **openclaw security audit --json**



#### 3. Troubleshooting

| Commands                                 | Functions                                                    |
| ---------------------------------------- | ------------------------------------------------------------ |
| openclaw doctor                          | -                                                            |
| openclaw doctor --yes                    | -                                                            |
| openclaw doctor --repair                 | 无需提示接受默认值（包括适用时的重启/服务/沙箱修复步骤）     |
| openclaw doctor --repair --force         | 无需提示应用推荐的修复（安全时进行修复 + 重启）              |
| openclaw doctor --non-interactive        | 也应用激进的修复（覆盖自定义 supervisor 配置                 |
| openclaw doctor --deep                   | 无需提示运行，仅应用安全迁移（配置规范化 + 磁盘状态移动）。跳过需要人工确认的重启/服务/沙箱操作。 检测到时自动运行遗留状态迁移。 |
| openclaw doctor --generate-gateway-token | 修复gateway token确实问题。疑问：如何在安装部署的时候自动生成？ |

#### 4. Clawhub skills

1. `npm install -g @openclaw/clawhub-cli`
2. `clawhub login`（浏览器流程）或 `clawhub login --token <token>`
   `clawhub logout`
   `clawhub whoami`
3. `clawhub search "calendar" --limit <n>：最大结果数`
4. `clawhub install /frontend-design`



#### 5. Openclaw Security Audit

⛔ **1008 unauthorized / gateway token missing** ⛔

1. ✅ **Fast fix (UI):** open the dashboard using
   `openclaw dashboard`
   (this opens with the correct token automatically, instead of raw `http://127.0.0.1:18789/`).
2. ✅ **Fast fix (CLI/RPC):** ensure your shell has token context (OpenClaw CLI normally does). If using custom WS client, send `auth.token` in connect params.
3. ✅ **If still failing:** restart service and retry:
   `openclaw gateway restart` then `openclaw dashboard`.



---

## 奇难杂症

1. Openclaw 没有执行权限
- `openclaw config set tools.profile full`
- `openclaw config set tools.allow_exec true`
- `openclaw config set tools.allow_filesystem true`
- `openclaw config set tools.allow_network true`
- `openclaw config set tools.allow_shell true`

2. Openclaw 缺失 gateway token
- `openclaw doctor --generate-gateway-token`



---



## 记忆系统操作
1. `openclaw config get agents.defaults.workspace`
2. `openclaw config get plugins.load.paths`
3. `openclaw config get plugins.slots.memory`
4. `openclaw config get plugins.entries.memory-lancedb-pro`





---