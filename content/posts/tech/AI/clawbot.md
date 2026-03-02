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
- 




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

#### 6. <u>Memory Optimization</u>
1. 安装 LanceDB Pro [win4r_lancedb_pro](https://github.com/win4r/memory-lancedb-pro)
2. 获取 Jina API Key [Jina Official](https://jina.ai/api-dashboard/)
3. 用普通话让 OpenClaw 安装LanceDB Pro
   - 这是jina AI的API Key: <your_api_key> 请帮我为OpenClaw安装这个记忆插件: https://github.com/win4r/memory-lancedb-pro
4. 在 OpenClaw dashboard  / Whataspp or Telegram：
   - 拷贝 / 粘贴下面的内容:
```markdown
将下面的铁律存入memory.md

# LanceDB Operational Iron Rules

> Extracted from MEMORY.md - rules directly related to LanceDB read/write operations.

## 1. Dual0Layer Memory Storage (IRON LAW)

Every pitfall/lesson learned → IMMEDIATELY store **TWO** memories to LanceDB before moving on:
- **Technical layer**: `Pitfall: [symptom]. Cause: [root cause]. Fix: [solution]. Prevention: [how to avoid]` (category: fact, importance ≥ 0.8)
- **Principle layer**: `Decision principle ([tag]): [behavioral rule]. Trigger: [when it applies]. Action: [what to do]` (category: decision, importance ≥ 0.85)
- After each store, **immediately `memory_recall`** with anchor keywords to verify retrieval. If not found, rewrite and re-store.
- Missing either layer = incomplete. Do NOT proceed to next topic until both are stored and verified.
- Also update relevant SKILL.md files to prevent recurrence.

## 2. LanceDB Hygiene
Entries must be short and atomic (< 500 chars). Never store raw conversation summaries, large blobs, or duplicates. Prefer structured format with keywords for retrieval.

## 3. Recall before retry
On ANY tool failure, repeated error, or unexpected behavior, ALWAYS `memory_recall` with relevant keywords (error message, tool name, symptom) BEFORE retrying. LanceDB likely already has the fix. Blind retries waste time and repeat known mistakes.

## 4. Confirm the target code base before editing
When working on memory plugins, confirm you are editing the intended package (e.g., `memory-lancedb-pro` vs built-in `memory-lancedb`) before making changes; use `memory_recall` + filesystem search to avoid patching the wrong repo.

## 5. Any changes to the plugin code must clear the jiti cache（MANDATORY）
After modifying ANY `.ts` file under `plugins/`, MUST run `rm -rf /tmp/jiti/` BEFORE `openclaw gateway restart`. jiti caches compiled TS; restart alone loads STALE code. This has caused silent bugs multiple times. Config-only changes do NOT need cache clearing.

```

5. 可以配置 LanceDB Pro 为全局使用，或者独立agent使用

   - 记忆 scope 隔离策略

     - 每个 agent 有自己的私有作用域：`agent:<id>` 
       - 存到 `agent:<id>` 的记忆 → 只有该 agent 可见
     - 另外可访问公共作用域：`global`
       - 存到 `global` 的记忆 → 其他有权限的 agent 可共享看到
     - 想“完全不共享”，我可以帮你把配置改成每个 agent 只允许自己的 `agent:<id>` scope，不给 `global` 读写权限

     

6. 

7. 检查 `memory slot` 已指向本插件:
   ```markdown
   # 期望看到：plugins.slots.memory = "memory-lancedb-pro"
   openclaw config get plugins.slots.memory
   ```

   [参考OpenClaw文档]([memory - OpenClaw](https://docs.openclaw.ai/zh-CN/cli/memory#memory))

8. 

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
