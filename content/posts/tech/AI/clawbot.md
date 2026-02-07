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

##### 方案一 npm / pnpm

:one: 官方网站 https://openclaw.ai/

:two: 执行安装` sudo npm install -g openclaw@latest` && `sudo openclaw onboard --install-daemon` 

:three: 配置AI API key 和 Telegram bot 

:four: ​执行 `source ~/.bashrc`

:five: ​Dashboard https://127.0.0.1:18789



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



