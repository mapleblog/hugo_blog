+++
title = 'OpenClaw'
date = 2026-02-07T11:12:51+08:00
draft = true
slug = "7dd23a0"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# OpenClaw AI Assistance

OpenClaw 官方文档 [Read]([Docker - OpenClaw](https://docs.openclaw.ai/install/docker))

### 操作命令
#### 1. <u>Quick Start</u>

- openclaw gateway start 
- openclaw gatewat restart
- openclaw dashboard
- /reasoning on
- /reasoning off




#### 2. <u>Openclaw Security Audit</u>

**openclaw security audit** 
**openclaw security audit --deep** 
**openclaw security audit --fix** 
**openclaw security audit --json**



#### 3. <u>Openclaw Security Audit</u>

⛔ **1008 unauthorized / gateway token missing** ⛔

1. ✅ **Fast fix (UI):** open the dashboard using
   `openclaw dashboard`
   (this opens with the correct token automatically, instead of raw `http://127.0.0.1:18789/`).
2. ✅ **Fast fix (CLI/RPC):** ensure your shell has token context (OpenClaw CLI normally does). If using custom WS client, send `auth.token` in connect params.
3. ✅ **If still failing:** restart service and retry:
   `openclaw gateway restart` then `openclaw dashboard`.

#### 4. <u>Clawhub skills</u>
1. `npm install -g @openclaw/clawhub-cli`
2. `clawhub login`（浏览器流程）或 `clawhub login --token <token>`
   `clawhub logout`
   `clawhub whoami`
3. `clawhub search "calendar" --limit <n>：最大结果数`
4. `clawhub install /frontend-design`
5. 


#### 5. <u>Troubleshooting</u>

| Commands                          | Functions                                                    |
| --------------------------------- | ------------------------------------------------------------ |
| openclaw doctor                   | -                                                            |
| openclaw doctor --yes             | -                                                            |
| openclaw doctor --repair          | 无需提示接受默认值（包括适用时的重启/服务/沙箱修复步骤）     |
| openclaw doctor --repair --force  | 无需提示应用推荐的修复（安全时进行修复 + 重启）              |
| openclaw doctor --non-interactive | 也应用激进的修复（覆盖自定义 supervisor 配置                 |
| openclaw doctor --deep            | 无需提示运行，仅应用安全迁移（配置规范化 + 磁盘状态移动）。跳过需要人工确认的重启/服务/沙箱操作。 检测到时自动运行遗留状态迁移。 |



### Ubuntu OpenClaw 安装

> [!TIP]
>
> Pre-requirement:
>
> - Git bash
>
> - Node.js
>
> - npm
>
>   
>

##### 方案一 npm / pnpm

:one: 官方网站 https://openclaw.ai/

:two: 执行安装` sudo npm install -g openclaw@latest` && `sudo openclaw onboard --install-daemon` 

:three: 配置AI API key 和 Telegram bot 

:four: 执行 `source ~/.bashrc`

:five: Dashboard https://127.0.0.1:18789



##### 方案二 Clone and build

:one: Clone the OpenClaw repo and build:

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
pnpm install
pnpm ui:build
pnpm build
```

:two: Link the CLI
Make the `openclaw` command available globally:

```bash
pnpm link --global
```

Alternatively, skip the link and run commands via `pnpm openclaw...` from inside the repo.

:three: Run onboarding

```bash
openclaw onboard --install-daemon
```

:four: Reactive Openclaw
```bash​
openclaw gateway restart
```

:five: Install plugins​
```bash
openclaw plugins install <plguin_name>
--> browse the marketplace in https://clawhub.ai/skills
```

> [!TIP]
>
> <u>**Pairing Required**</u>
>
> 1. Check pending WhatsApp pairing requests
>    ```bash
>    openclaw pairing list whatsapp
>    ```
>
> 2. You should see a code (8 chars)
>
> 3. Approve that code
>    ```bash
>    openclaw pairing approve whatsapp <CODE> --notify
>    ```
>
> 4. Optional quick verify
>    ```bash
>    openclaw pairing list whatsapp
>    ```
>
> ---
>
> <u>**Pairing/auth state issue**</u>
>
> **Reason:**  
>
> 1. Cron / API calls were failing with: gateway closed (1008): pairing required
> 2. This means the CLI identity needed re-approval as an operator device (repair flow), even though WhatsApp itself was connected.
>
> **Solution:**
>
> 1. run `openclaw status` 
>    Confirmed gateway + WhatsApp were healthy.
>
> 2. run `openclaw devices list`
>    Found a pending repair request:
>    	role = operator, flag = repair
>
> 3. run `openclaw devices approve`
>    Approved the pending operator device pairing
>
> 
>





## 创建多个openclaw agent 在 telegram

:one: **@BotFather** 执行 `/newbot` 创建新的 agent && 创建新的群组
:two: 将 **OpenClaw** 添加到群组
:three: 授权 **OpenClaw agent** 为 **admin**
:four: 获取群组ID（在telegram web点击群组，然后在网址的link尾端有号码）
:five: 描述agent角色任务
:six: Create  separate OpenClaw agents: [Guide of agent creation](.\openclaw_agent.md)

```markdown
## Step 1 Part: Openclaw
mkdir ~/.openclaw/workspaces/<your_new_agents>/

~/.openclaw/workspaces/ai-news/
						├── SOUL.md    ← personality & style
						└── AGENTS.md  ← what it does & how		

---

## Step 2 Part: Openclaw
- Create SOUL.md in your `vim ~/.openclaw/workspaces/<your_new_agents>/SOUL.md`
This file defines WHO the agent is — its personality, tone, and style:

---

- Create AGENTS.md in your `vim ~/.openclaw/workspaces/<your_new_agents>/AGENTS.md`
This file defines WHAT the agent does — its responsibilities and tasks:

---

Configure model/auth for this agent, require token from anthropic/openAI


## Step 3 Part: Telegram
- Create Your Telegram Group like "Python Tutor" or "Learn Python"
- Add to config: Register in OpenClaw + bind to a chat
- Add your specific Clawbot to the group
- Obtain group chat ID

```



## 创建多个openclaw agent 在 telegram
