+++
title = 'OpenClaw Build'
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

# OpenClaw 安装

> [!TIP]
>
> Pre-requirement:
>
> - Git bash [git install](https://git-scm.com/install/linux)
>
> - Node.js [nodejs install](https://nodejs.org/en/download)
>
> - npm [nodejs install](https://nodejs.org/en/download)
>
>   
>

## 快速部署方案一: npm 

:one: 执行命令 `npm install -g openclaw@latest`

:two: 执行命令 `openclaw onboard` 进行初始化配置

:three: 执行命令 `openclaw dashboard` 打开网页控制面板



## 向量记忆系统配置
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

7. 检查 `memory slot` 已指向本插件:
   ```markdown
   # 期望看到：plugins.slots.memory = "memory-lancedb-pro"
   openclaw config get plugins.slots.memory
   ```

   [参考OpenClaw文档]([memory - OpenClaw](https://docs.openclaw.ai/zh-CN/cli/memory#memory))

   

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




