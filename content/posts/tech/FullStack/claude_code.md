+++
title = 'Claude Code'
date = 2026-02-02T12:49:14+08:00
draft = false
slug = "832522f"
description = ""
summary = ""
tags = [ "代码", "开发" ]
categories = [ "code" ]
cover = ""
author = "MapleScraps"

+++

# Claude Code
#### Part.1 初始化搭建和配置基础交互

- 安装 Claude Code
- 登录与授权
- 第一个实战问题
- 三种模式详解（默认 / 自动 / 规划）
  - shift + tab
    - 默认模式 =？ for shortcuts
    - 自动模式 = accept edits on
    - 规划模式 = plan mode on



#### Part.2  复杂任务处理与终端控制

- **执行终端命令（Bash）**
  - ctrl + g（打开编辑器，编写好后需要保存，然后关闭编辑器）
- **使用规划模式（Plan Mode）**
- **跳过所有权限检测（Dangerously-Skip-Permissions）**
  - 在终端执行 claude --dangerously-skip-permissions（会进入放飞自我模式，所有操作自动完成）

- **后台任务管理（Bakground Tasks）**



#### Part.3 多模态与上下文

- **版本滚回（Rewind）**
  - /rewind
  - 按两次 esc，选择要回滚的版本
- **图片处理**
  - 直接拖拽图片到终端
  - ctrl + c | ctrl + v
- **安装MCP Server（以Figma为例）**
  - claude mcp add --transport http figma https://mcp.figma.com/mcp
- **恢复历史会话（Resume）**
  - 启动claude code 后，执行 /resume
  - claude -c
- **使用MCP工具还原设计稿**
- **上下文压缩与清除**
  - /compact 
  - /clear
- **项目及以文件（CLAUE.md）**
  - /init
  - /memory



#### Part.4 高级功能扩展与定制

- **Skill** 与 **SubAgent** 的区别

- **Plugin**
  
  - `/plugin install plugin-name@claude-plugins-official`
  
      |      | Plugin                     | Plugin                        |
      | ---- | -------------------------- | ----------------------------- |
      | 定义 | 单个技能的定义文件         | 技能包的发布格式              |
      | 数量 | 一个文件 = 一个技能        | 一个插件 = 多个技能           |
      | 安装 | 手动复制到 .claude/skills/ | 通过命令安装：/plugin install |
      | 来源 | 自己创建或官方             | 官方仓库或社区                |
      | 类比 | 一个工具                   | 一个工具箱（含多个工具）      |
  

#### Part.5 最新更新功能

- /btw 旁问模式，不打算主任务执行
- cowork 操作协作员，允许AI在自己的电脑执行指定的操作
- 

## 使用BigModel 智谱来调用Claude Code

Claude Code 对于中国大陆用户，直接使用面临网络与账号双重门槛。但可以通过本地部署 + 国产大模型兼容层（GLM/DeepSeek）方案，实现无障碍安装使用。
**操作起来很简单，只需要3个步骤即可。**

## 1. 基础环境与工具安装

Claude Code 依赖 Node.js 环境运行。**请确保已安装 [Node.js](https://nodejs.org/)**。
下载Nodejs之后，双击安装即可。

打开终端（Windows 推荐 PowerShell/CMD，Mac 使用 Terminal），按顺序执行以下命令完成从检查到安装的全流程：

1. 检查 Node.js 环境（必须有版本号返回）
```bash
node -v
npm -v
```
2. 安装 Claude Code（使用 -g 进行全局安装）
```bash
npm install -g @anthropic-ai/claude-code
```
3. 验证安装
```bash
claude --version
```
看到版本号即安装成功。输出示例：2.1.2 (Claude Code) 

如果在npm install这一步遇到卡顿，建议搜索watt toolkit加速器（windows应用商店搜索然后安装），或者使用国内npm中转，具体做法是在npm install命令后面添加参数：

```bash
npm install -g @anthropic-ai/claude-code --registry=https://registry.npmmirror.com
```


## 2. Claude账号问题

安装完成后，需要解决“谁来驱动”的问题，**根据你的网络与账号情况**选择路径：

*   **路径 A：标准模式（美国、欧洲等支持地区）**
    **如果你身处海外环境且有 Anthropic 账号**，直接运行 `claude login`，系统会打开浏览器，让你登录Claude，进行 OAuth 授权。登录完成后即可顺畅使用Claude Code。那么对于你来说，现在已经安装成功了。

*   **路径 B：兼容模式（中国大陆推荐）**
    国内用户无需注册 Anthropic 账号，可直接使用**智谱 GLM**或**DeepSeek**的 API 来驱动 Claude Code。这两者均提供了官方兼容接口。具体看第三步。

## 3. 核心配置：使用兼容模型，绕过Claude登录验证

为了让 Claude Code 连接到兼容模型（智谱GLM, DeepSeek)。

- 请求 / 响应结构与 Anthropic 基本一致
- 可直接作为 Claude Code 的后端
- 不需要登录 Anthropic 官网账号

### 方案一：通过命令行设置环境变量

我们需要配置 `BASE_URL` 和 `API_KEY`
为了避免每次重启终端丢失配置，以下命令将直接写入系统**永久环境变量**。

*   **智谱 GLM Base URL**: `https://open.bigmodel.cn/api/anthropic`
*   **DeepSeek Base URL**: `https://api.deepseek.com/anthropic`

请根据你的系统，复制对应的命令块运行（只需运行一次）：

#### Windows 用户 (CMD 命令提示符)
使用 setx 命令写入用户级永久变量
```cmd
setx ANTHROPIC_BASE_URL "https://open.bigmodel.cn/api/anthropic"
setx ANTHROPIC_AUTH_TOKEN "你的_GLM_API_KEY"
setx ANTHROPIC_MODEL "glm-4.6"
```

注意：运行后需重启 CMD 窗口才会生效

#### macOS / Linux 用户 (Shell)
```bash
echo 'export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/anthropic"' >> ~/.zshrc
echo 'export ANTHROPIC_AUTH_TOKEN="你的_GLM_API_KEY"' >> ~/.zshrc
echo 'export ANTHROPIC_MODEL=glm-4.6' >> ~/.zshrc

source ~/.zshrc
```

如果使用DeepSeek则使用DeepSeek的url和api key，模型名则是deepseek-chat。

### 方案二：通过配置文件修改环境变量

通过修改本地配置文件，可以强制 Claude Code (CLI) 连接到 DeepSeek 或其他兼容 Anthropic 协议的模型，并跳过官方的浏览器登录验证。

#### 1. 文件结构总览
需要修改的文件位于用户根目录下。请确保文件位置和层级完全一致：

```text
C:\Users\用户名\
│
├── 📄 .claude.json                 <-- 【状态文件】 修改这个文件内容，添加"hasCompletedOnboarding": true,
│
└── 📂 .claude\                     <-- 【配置文件夹】 这是claude全局文件夹
    └── ⚙️ settings.json            <-- 【配置文件】 新建这个settings.json文件，并添加环境变量
```

#### 2. 详细配置指南

1. 配置 API 连接 (`.claude\settings.json`)
此文件用于接管网络请求，将其重定向到第三方服务（如 GLM/DeepSeek）。
*   **路径**: `C:\Users\你的用户名\.claude\settings.json`
*   **内容**: 新建这个setting.json文件，用记事本打开，在里面添加下面这段内容：

```json
# 编辑或新增 `settings.json` 文件
# MacOS & Linux 为 `~/.claude/settings.json`
# Windows 为`用户目录/.claude/settings.json`
# 新增或修改里面的 env 字段
# 注意替换里面的 `your_zhipu_api_key` 为您上一步获取到的 API Key
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "your_zhipu_api_key",
    "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-4.7",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-4.7"
  }
}

```

2. 绕过登录验证 (`.claude.json`)
此文件用于伪造“老用户”状态，防止 CLI 启动时弹出浏览器进行 OAuth 验证。
*   **路径**: `C:\Users\你的用户名\.claude.json` 
*   **内容**: 用记事本打开这个文件，在其中添加一项

```json
{
  "hasCompletedOnboarding": true
}
```



## 4. 启动与常用指令

环境变量配置完毕后，无需登录，直接启动即可。

*   **启动程序**：在命令行中输入 `claude`，然后回车。
    *   *成功标志*：出现 "Welcome to Claude Code" 欢迎语，且未弹出浏览器。
*   **退出程序**：在交互界面输入`exit`，回车。

**常用交互指令**：
*   `/clear`：清除上下文记忆（节省 Token，开启新任务时推荐）。
*   `/compact`：压缩上下文（处理长任务时使用）。
*   `/help`：查看所有可用命令。
*   `Alt + Enter` (Win) / `Opt + Enter` (Mac)：在对话框中换行。

## Agents 协作团队
1. 我想建立一个以agent角色的个人事务助手，成员有：
- 大头（管家）- 当用户开始回应，触发调用助手，分配任务，监管任务进度是否完成或者中断
- 新闻闻（新闻助手） - 访问著名的各大新闻平台，收集和AI相关的新闻，保存到`news.md`。新的一天覆盖前一天所有内容
- 文档档（文档助手） - 读取`news.md`，然后进行过滤，以总结每个标题的重点，标题内容字数 >= 50 =< 70
- 提醒醒 （提醒助手）- 

2. 定义agent 角色：

   - 用 System Prompt：系统提示词定义角色

   - 以 role.md 形式命名文档
   - 如何赋予 skills？如何定义skills?
   - 如何赋予 plugin? 如何调用 plugin?

3. 了解 CLAUDE.md ， Agent.md , SKILL.md 三者之间的协作关系

   - **CLAUDE.md          →    公司员工手册（所有人都要遵守）**
         │
         └── **新闻 Agent 系统提示词  →  某个岗位的职责说明**
                 │
                 └── **Skill 文件们  →  具体岗位的操作手册**



## Harness Engineering

#### PLANNER.md / AGENTS.md

````markdown
# AGENTS.md

> Master index for the Harness engineering workflow. Every agent reads this file first before taking any action.

---

## 1. Project Overview

**OfficeKit** is a lightweight, no-login web-based office utility platform built for teams of 20+ users. It provides a collection of browser-accessible mini-tools for everyday office tasks — starting with PDF manipulation (merge, split, compress) and expanding iteratively to image processing (compress/convert) and QR/barcode generation.

The stack is **Next.js 15 + TypeScript + Tailwind CSS**, deployed on a self-hosted VPS via Docker. File processing runs entirely server-side using **pdf-lib** (PDF operations) and **sharp** (image operations) — no third-party cloud APIs, no user authentication required.

The product follows an **iterative release strategy**: MVP ships with the PDF module, with image tools and QR/barcode generation added in subsequent phases. The UI is English-first.

**Current phase: Phase 0 — Bootstrapping (0 → 1)**

---

## 2. Document Map & Responsibilities

```
                  ┌─────────────────┐
                  │   AGENTS.md     │  ← You are here. Read first, always.
                  └────────┬────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
   STRATEGY LAYER    EXECUTION LAYER    FEEDBACK LAYER
        │                  │                  │
   ARCHITECTURE.md     TODO.md            STATUS.md
   PLAN.md             TASKS.md           LOGS.md
```

| Document | Layer | Purpose | Read when… | Update when… | Owner |
|---|---|---|---|---|---|
| **AGENTS.md** | Index | Master entry point and doc map | Always — read first | The doc model itself changes | Lead agent / human reviewer |
| **ARCHITECTURE.md** | Strategy | System design, module boundaries, data flow, tech stack decisions, file-processing pipeline | Starting any task that touches API routes, file handling, or adding a new tool module | A new module is added, a library decision changes, or the folder structure is revised | Design agent / human architect |
| **PLAN.md** | Strategy | Milestones, phases, module rollout sequence, success criteria per phase | Planning a new sprint or phase, or when scope changes | A phase is completed or a milestone shifts | Lead agent / PM |
| **TODO.md** | Execution | Backlog of all planned work — features, refactors, fixes not yet started | Picking up new work; checking what's next | New work is identified, scoped, or deprioritized | Any agent |
| **TASKS.md** | Execution | In-flight tasks with acceptance criteria, assignee, and status | Starting a task; checking what is actively being worked | Promoting an item from TODO, changing task status (in-progress → blocked → done) | Executing agent |
| **STATUS.md** | Feedback | Current snapshot: what's done, what's blocked, what's next | A human or new agent joins and needs to orient quickly | End of every work session; after any task state change | Executing agent |
| **LOGS.md** | Feedback | Append-only chronological record of decisions, actions, and outcomes | Investigating why a past decision was made | Any non-trivial action completes — append only, never edit history | Any agent |

---

## 3. Agent Workflow (Read → Act → Write)

Follow this sequence for every unit of work without exception.

1. **Orient** — Read `AGENTS.md` (this file), then `STATUS.md` to get the current project snapshot. Do not skip this even if you think you know the state.

2. **Plan** — Consult `PLAN.md` for the active phase and milestone. If the task touches any API route, the file-processing pipeline, or the module registry in `src/modules/`, read the relevant section of `ARCHITECTURE.md` before writing any code.

3. **Pick** — Pull the next prioritized item from `TODO.md`. Promote it into `TASKS.md` with:
   - Clear acceptance criteria (what "done" looks like)
   - Estimated scope (S / M / L)
   - Any blockers or dependencies noted upfront

4. **Execute** — Do the work. Follow the module boundary conventions in `ARCHITECTURE.md`. Do not silently deviate from the established folder structure or API contract — if a deviation is needed, update `ARCHITECTURE.md` first and log the decision in `LOGS.md`.

5. **Record** — After completing or blocking on a task:
   - Mark the task done/blocked in `TASKS.md`
   - Append a timestamped entry to `LOGS.md` (what was done, key decisions made, why)
   - Overwrite `STATUS.md` with the new snapshot (prior state must already be in `LOGS.md`)

6. **Hand off** — Leave `STATUS.md` in a state where the next agent or a team member can orient in under 60 seconds. Include: last completed task, current blocker (if any), and the single next recommended action.

---

## 4. Update Rules

```
ARCHITECTURE.md  — updated by: design agent / human architect
                   when: a new tool module is scaffolded, a library is added/swapped,
                         or the file-processing pipeline changes
                   cadence: low frequency; deliberate, reviewed changes only

PLAN.md          — updated by: lead agent / human PM
                   when: a phase boundary is crossed or milestone scope shifts
                   cadence: per phase; not during active execution sprints

TODO.md          — updated by: any agent
                   when: new work is identified, scoped, or removed from scope
                   cadence: continuous; the backlog is always the source of next work

TASKS.md         — updated by: the executing agent
                   when: a task is promoted from TODO, changes state, or is completed/blocked
                   cadence: continuous during active development

STATUS.md        — updated by: the executing agent
                   when: end of every work session or after any task state change
                   cadence: at minimum once per working day during active development

LOGS.md          — updated by: any agent
                   when: any non-trivial action completes (code merged, decision made,
                         blocker hit, architecture revised)
                   cadence: append-only — entries are never edited or deleted

AGENTS.md        — updated by: lead agent / human reviewer
                   when: the document model itself changes (new doc added, workflow revised)
                   cadence: rare; treat as a breaking change
```

**Protective rules:**

1. **LOGS.md is append-only.** Never edit or delete past entries. `STATUS.md` is a mutable snapshot — overwrite freely, but the superseded state must already be captured in `LOGS.md`.

2. **One source of truth per fact.** If two documents conflict, the layer hierarchy resolves it:
   `ARCHITECTURE.md / PLAN.md` > `TASKS.md / TODO.md` > `STATUS.md / LOGS.md`

---

## 5. Commands & Tooling

```bash
# ── Setup ────────────────────────────────────────────────
npm install                        # Install all dependencies
cp .env.example .env.local         # Configure environment variables

# ── Development ──────────────────────────────────────────
npm run dev                        # Start Next.js dev server (http://localhost:3000)

# ── Type checking & Lint ─────────────────────────────────
npm run type-check                 # tsc --noEmit
npm run lint                       # ESLint via next lint
npm run lint:fix                   # Auto-fix lint issues

# ── Testing ──────────────────────────────────────────────
npm run test                       # Run unit tests (Vitest / Jest)
npm run test:watch                 # Watch mode

# ── Build & Production ───────────────────────────────────
npm run build                      # Next.js production build
npm run start                      # Start production server

# ── Docker (VPS deployment) ──────────────────────────────
docker build -t officekit .        # Build Docker image
docker compose up -d               # Start all services (app + optional reverse proxy)
docker compose down                # Stop services
docker compose logs -f app         # Tail application logs
```

> ⚠️ TBD — Specific environment variables (e.g. `MAX_FILE_SIZE`, `UPLOAD_DIR`) and the Dockerfile have not yet been defined. Add them to `ARCHITECTURE.md` once decided during Phase 0 bootstrapping.

---

*Last updated: Phase 0 — Bootstrapping | Next action: scaffold the Next.js project and draft `ARCHITECTURE.md` with the module registry and file-processing pipeline design.*
````



---



#### GENERATOR.md

````markdown
# GENERATOR.md

> **Generator Agent** for OfficeKit.
> This agent's sole responsibility is to scaffold the complete project structure from zero — creating every folder, file, and boilerplate needed so the Planner and Executor agents can begin feature work immediately.
>
> Read `AGENTS.md` first. Then execute every step in this document top-to-bottom, in order. Do not skip steps. Do not assume a file already exists — check, then create.

---

## 0. Pre-flight Checklist

Before writing a single file, confirm the following. If any check fails, stop and report.

```
[ ] Node.js >= 18.17 is available        (node -v)
[ ] npm >= 9 is available                (npm -v)
[ ] The target directory is empty or      (ls -la)
    only contains .git/
[ ] AGENTS.md is present at project root  (cat AGENTS.md)
```

---

## 1. Scaffold Next.js Project

If the project has not been initialized yet, run:

```bash
npx create-next-app@latest . \
  --typescript \
  --tailwind \
  --eslint \
  --app \
  --src-dir \
  --import-alias "@/*" \
  --no-turbopack
```

> This produces the baseline `src/`, `public/`, `tsconfig.json`, `tailwind.config.ts`, `next.config.ts`, and `package.json`.

---

## 2. Install Core Dependencies

```bash
# PDF processing
npm install pdf-lib

# Image processing
npm install sharp
npm install --save-dev @types/sharp

# QR / Barcode generation (Phase 2 — install now, wire later)
npm install qrcode
npm install --save-dev @types/qrcode

# Utility
npm install clsx tailwind-merge
npm install lucide-react

# File upload handling
npm install formidable
npm install --save-dev @types/formidable
```

---

## 3. Create the Full Folder Structure

Run the following shell block **in one pass**. It creates every directory and placeholder file the project needs. Each `mkdir -p` is idempotent — safe to re-run.

```bash
# ── Source module tree ────────────────────────────────────────────────────────

# Core layout & shared UI
mkdir -p src/components/ui
mkdir -p src/components/layout

# Tool module: PDF
mkdir -p src/modules/pdf/components
mkdir -p src/modules/pdf/lib
mkdir -p src/modules/pdf/types

# Tool module: Image (scaffolded now, activated in Phase 2)
mkdir -p src/modules/image/components
mkdir -p src/modules/image/lib
mkdir -p src/modules/image/types

# Tool module: QR / Barcode (scaffolded now, activated in Phase 3)
mkdir -p src/modules/qrcode/components
mkdir -p src/modules/qrcode/lib
mkdir -p src/modules/qrcode/types

# App routes (Next.js App Router)
mkdir -p src/app/tools/pdf
mkdir -p src/app/tools/image
mkdir -p src/app/tools/qrcode

# Server-side API routes
mkdir -p src/app/api/pdf/merge
mkdir -p src/app/api/pdf/split
mkdir -p src/app/api/pdf/compress
mkdir -p src/app/api/image/compress
mkdir -p src/app/api/image/convert
mkdir -p src/app/api/qrcode/generate

# Shared utilities & types
mkdir -p src/lib
mkdir -p src/types
mkdir -p src/config
mkdir -p src/hooks

# Public static assets
mkdir -p public/icons
mkdir -p public/og

# Temporary upload/output directory (server-side, git-ignored)
mkdir -p tmp/uploads
mkdir -p tmp/outputs

# Harness engineering docs
mkdir -p docs

# Tests
mkdir -p src/__tests__/modules/pdf
mkdir -p src/__tests__/modules/image
mkdir -p src/__tests__/api

# Docker & CI
mkdir -p .github/workflows
```

---

## 4. Generate Placeholder Source Files

After the folders exist, write the following placeholder files. Each file is minimal but **valid TypeScript** — the project must compile after this step.

### 4.1 Global config — `src/config/modules.ts`

```bash
cat > src/config/modules.ts << 'EOF'
/**
 * Module Registry
 * Add a new entry here when activating a new tool module.
 * The homepage and nav are generated from this list.
 */
export type ModuleStatus = "active" | "coming-soon";

export interface ToolModule {
  id: string;
  label: string;
  description: string;
  href: string;
  icon: string;
  status: ModuleStatus;
  phase: number;
}

export const MODULES: ToolModule[] = [
  {
    id: "pdf-merge",
    label: "Merge PDF",
    description: "Combine multiple PDF files into one.",
    href: "/tools/pdf",
    icon: "FileStack",
    status: "active",
    phase: 1,
  },
  {
    id: "pdf-split",
    label: "Split PDF",
    description: "Extract pages or ranges from a PDF.",
    href: "/tools/pdf",
    icon: "Scissors",
    status: "active",
    phase: 1,
  },
  {
    id: "pdf-compress",
    label: "Compress PDF",
    description: "Reduce PDF file size without quality loss.",
    href: "/tools/pdf",
    icon: "FileDown",
    status: "active",
    phase: 1,
  },
  {
    id: "image-compress",
    label: "Compress Image",
    description: "Compress JPG, PNG, and WebP images.",
    href: "/tools/image",
    icon: "Image",
    status: "coming-soon",
    phase: 2,
  },
  {
    id: "image-convert",
    label: "Convert Image",
    description: "Convert between image formats.",
    href: "/tools/image",
    icon: "RefreshCw",
    status: "coming-soon",
    phase: 2,
  },
  {
    id: "qrcode-generate",
    label: "QR Code",
    description: "Generate QR codes and barcodes.",
    href: "/tools/qrcode",
    icon: "QrCode",
    status: "coming-soon",
    phase: 3,
  },
];
EOF
```

### 4.2 Shared types — `src/types/api.ts`

```bash
cat > src/types/api.ts << 'EOF'
export interface ApiSuccess<T = unknown> {
  ok: true;
  data: T;
}

export interface ApiError {
  ok: false;
  error: string;
  code?: string;
}

export type ApiResponse<T = unknown> = ApiSuccess<T> | ApiError;
EOF
```

### 4.3 Shared utility — `src/lib/response.ts`

```bash
cat > src/lib/response.ts << 'EOF'
import { NextResponse } from "next/server";
import type { ApiResponse } from "@/types/api";

export function ok<T>(data: T, status = 200) {
  return NextResponse.json<ApiResponse<T>>({ ok: true, data }, { status });
}

export function err(error: string, status = 400, code?: string) {
  return NextResponse.json<ApiResponse>({ ok: false, error, code }, { status });
}
EOF
```

### 4.4 PDF types — `src/modules/pdf/types/index.ts`

```bash
cat > src/modules/pdf/types/index.ts << 'EOF'
export interface MergeInput {
  files: Buffer[];
}

export interface SplitInput {
  file: Buffer;
  ranges: string; // e.g. "1-3,5,7-9"
}

export interface CompressInput {
  file: Buffer;
}

export interface PdfResult {
  buffer: Buffer;
  filename: string;
  sizeBytes: number;
}
EOF
```

### 4.5 PDF lib stubs — `src/modules/pdf/lib/merge.ts`

```bash
cat > src/modules/pdf/lib/merge.ts << 'EOF'
import { PDFDocument } from "pdf-lib";
import type { MergeInput, PdfResult } from "../types";

export async function mergePdfs({ files }: MergeInput): Promise<PdfResult> {
  const merged = await PDFDocument.create();

  for (const fileBuffer of files) {
    const doc = await PDFDocument.load(fileBuffer);
    const pages = await merged.copyPages(doc, doc.getPageIndices());
    pages.forEach((page) => merged.addPage(page));
  }

  const buffer = Buffer.from(await merged.save());
  return {
    buffer,
    filename: "merged.pdf",
    sizeBytes: buffer.byteLength,
  };
}
EOF
```

```bash
cat > src/modules/pdf/lib/split.ts << 'EOF'
// TODO: implement split logic in Phase 1 execution
export {};
EOF
```

```bash
cat > src/modules/pdf/lib/compress.ts << 'EOF'
// TODO: implement compress logic in Phase 1 execution
export {};
EOF
```

### 4.6 Image lib stub — `src/modules/image/lib/compress.ts`

```bash
cat > src/modules/image/lib/compress.ts << 'EOF'
// Activated in Phase 2 — stub only
export {};
EOF
```

```bash
cat > src/modules/image/lib/convert.ts << 'EOF'
// Activated in Phase 2 — stub only
export {};
EOF
```

### 4.7 QR lib stub — `src/modules/qrcode/lib/generate.ts`

```bash
cat > src/modules/qrcode/lib/generate.ts << 'EOF'
// Activated in Phase 3 — stub only
export {};
EOF
```

### 4.8 API route stubs

```bash
cat > src/app/api/pdf/merge/route.ts << 'EOF'
import { err } from "@/lib/response";

export async function POST() {
  // TODO: parse multipart form, call mergePdfs(), stream result
  return err("Not yet implemented", 501);
}
EOF

cat > src/app/api/pdf/split/route.ts << 'EOF'
import { err } from "@/lib/response";

export async function POST() {
  return err("Not yet implemented", 501);
}
EOF

cat > src/app/api/pdf/compress/route.ts << 'EOF'
import { err } from "@/lib/response";

export async function POST() {
  return err("Not yet implemented", 501);
}
EOF

cat > src/app/api/image/compress/route.ts << 'EOF'
import { err } from "@/lib/response";

export async function POST() {
  return err("Not yet implemented", 501);
}
EOF

cat > src/app/api/image/convert/route.ts << 'EOF'
import { err } from "@/lib/response";

export async function POST() {
  return err("Not yet implemented", 501);
}
EOF

cat > src/app/api/qrcode/generate/route.ts << 'EOF'
import { err } from "@/lib/response";

export async function POST() {
  return err("Not yet implemented", 501);
}
EOF
```

### 4.9 Page stubs

```bash
cat > src/app/tools/pdf/page.tsx << 'EOF'
export default function PdfToolsPage() {
  return (
    <main className="container mx-auto py-12">
      <h1 className="text-2xl font-semibold">PDF Tools</h1>
      <p className="mt-2 text-muted-foreground">Coming soon — Phase 1</p>
    </main>
  );
}
EOF

cat > src/app/tools/image/page.tsx << 'EOF'
export default function ImageToolsPage() {
  return (
    <main className="container mx-auto py-12">
      <h1 className="text-2xl font-semibold">Image Tools</h1>
      <p className="mt-2 text-muted-foreground">Coming soon — Phase 2</p>
    </main>
  );
}
EOF

cat > src/app/tools/qrcode/page.tsx << 'EOF'
export default function QrCodePage() {
  return (
    <main className="container mx-auto py-12">
      <h1 className="text-2xl font-semibold">QR Code Generator</h1>
      <p className="mt-2 text-muted-foreground">Coming soon — Phase 3</p>
    </main>
  );
}
EOF
```

---

## 5. Environment & Config Files

### 5.1 `.env.example`

```bash
cat > .env.example << 'EOF'
# Maximum upload file size in bytes (default: 20MB)
MAX_FILE_SIZE=20971520

# Temporary file directory (relative to project root)
UPLOAD_DIR=tmp/uploads
OUTPUT_DIR=tmp/outputs

# Node environment
NODE_ENV=development
EOF
```

### 5.2 `.gitignore` additions

```bash
cat >> .gitignore << 'EOF'

# OfficeKit — temp processing files
tmp/
.env.local
EOF
```

### 5.3 `next.config.ts` — allow large file body size

```bash
cat > next.config.ts << 'EOF'
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  experimental: {
    serverActions: {
      bodySizeLimit: "25mb",
    },
  },
  api: {
    bodyParser: false, // We handle multipart manually with formidable
  },
};

export default nextConfig;
EOF
```

### 5.4 `Dockerfile`

```bash
cat > Dockerfile << 'EOF'
FROM node:20-alpine AS base

# Install dependencies only when needed
FROM base AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci

# Build the app
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Production image
FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Create tmp dirs with correct ownership
RUN mkdir -p tmp/uploads tmp/outputs && chown -R nextjs:nodejs tmp/

USER nextjs
EXPOSE 3000
ENV PORT=3000

CMD ["node", "server.js"]
EOF
```

### 5.5 `docker-compose.yml`

```bash
cat > docker-compose.yml << 'EOF'
version: "3.9"
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - MAX_FILE_SIZE=20971520
      - UPLOAD_DIR=tmp/uploads
      - OUTPUT_DIR=tmp/outputs
    volumes:
      - ./tmp:/app/tmp
    restart: unless-stopped
EOF
```

---

## 6. Harness Docs Stubs

Create empty but valid stubs for the six supporting Harness docs so the full doc-set exists from day one.

```bash
cat > docs/ARCHITECTURE.md << 'EOF'
# ARCHITECTURE.md
> ⚠️ Stub — to be filled by the Design Agent after scaffolding is verified.

## System Overview
## Module Registry
## File Processing Pipeline
## API Contract
## Folder Structure Reference
## Environment Variables
EOF

cat > docs/PLAN.md << 'EOF'
# PLAN.md
> ⚠️ Stub — to be filled by the Planner Agent.

## Phase 1 — MVP (PDF Tools)
## Phase 2 — Image Tools
## Phase 3 — QR / Barcode
## Success Criteria
EOF

cat > docs/TODO.md << 'EOF'
# TODO.md

## Phase 1 — PDF Tools
- [ ] Implement PDF merge API route (`/api/pdf/merge`)
- [ ] Implement PDF split API route (`/api/pdf/split`)
- [ ] Implement PDF compress API route (`/api/pdf/compress`)
- [ ] Build PDF tools page UI with file drag-and-drop
- [ ] Write unit tests for pdf/lib/merge.ts
- [ ] Write unit tests for pdf/lib/split.ts

## Phase 2 — Image Tools
- [ ] Implement image compress (sharp)
- [ ] Implement image convert (sharp)
- [ ] Build image tools page UI

## Phase 3 — QR Code
- [ ] Implement QR code generation API
- [ ] Build QR code generator UI

## Infrastructure
- [ ] Set up GitHub Actions CI (lint + type-check + test)
- [ ] Configure Dockerfile output mode (standalone)
- [ ] Document deployment steps in README
EOF

cat > docs/TASKS.md << 'EOF'
# TASKS.md
> Active in-flight tasks only. Move items here from TODO.md when work begins.
> Format: Task | Status | Acceptance Criteria | Notes

| Task | Status | Acceptance Criteria | Notes |
|---|---|---|---|
| Scaffolding — run GENERATOR.md | 🔄 In Progress | `npm run build` passes; all folders exist | Generator agent executing |
EOF

cat > docs/STATUS.md << 'EOF'
# STATUS.md
> Current snapshot. Overwrite on every update. Prior state lives in LOGS.md.

**As of:** Phase 0 — Bootstrapping
**Last action:** Generator agent initiated
**Completed:** Project scaffold (directories, stubs, config files)
**Blocked:** Nothing
**Next:** Verify build passes → Planner agent drafts ARCHITECTURE.md
EOF

cat > docs/LOGS.md << 'EOF'
# LOGS.md
> Append-only. Never edit past entries.

---

### [Phase 0] Generator agent started
- Action: GENERATOR.md executed to scaffold OfficeKit project
- Decisions: pdf-lib + sharp for processing; formidable for multipart; no auth layer
- Outcome: pending build verification
EOF
```

---

## 7. Verification

After all files are created, run the following checks. **All must pass before the Generator agent's work is considered done.**

```bash
# 1. Type check — must produce zero errors
npm run type-check

# 2. Lint — must produce zero errors (warnings acceptable)
npm run lint

# 3. Build — must succeed
npm run build

# 4. Confirm folder tree
find src -type d | sort
find docs -type f | sort
```

Expected directory tree (abbreviated):

```
src/
├── app/
│   ├── api/
│   │   ├── pdf/merge/route.ts
│   │   ├── pdf/split/route.ts
│   │   ├── pdf/compress/route.ts
│   │   ├── image/compress/route.ts
│   │   ├── image/convert/route.ts
│   │   └── qrcode/generate/route.ts
│   ├── tools/
│   │   ├── pdf/page.tsx
│   │   ├── image/page.tsx
│   │   └── qrcode/page.tsx
│   ├── layout.tsx          ← from create-next-app
│   └── page.tsx            ← from create-next-app
├── components/
│   ├── ui/
│   └── layout/
├── config/
│   └── modules.ts
├── hooks/
├── lib/
│   └── response.ts
├── modules/
│   ├── pdf/
│   │   ├── components/
│   │   ├── lib/  (merge.ts, split.ts, compress.ts)
│   │   └── types/index.ts
│   ├── image/
│   │   ├── components/
│   │   ├── lib/  (compress.ts, convert.ts)
│   │   └── types/
│   └── qrcode/
│       ├── components/
│       ├── lib/  (generate.ts)
│       └── types/
└── types/
    └── api.ts

docs/
├── ARCHITECTURE.md
├── PLAN.md
├── TODO.md
├── TASKS.md
├── STATUS.md
└── LOGS.md

tmp/
├── uploads/    ← git-ignored
└── outputs/    ← git-ignored
```

---

## 8. Hand-off

When all verification checks pass, the Generator agent must:

1. Update `docs/TASKS.md` — mark the scaffolding task as ✅ Done
2. Append to `docs/LOGS.md`:

```
### [Phase 0] Scaffolding complete
- Action: All folders and stub files created; build verified
- Outcome: Ready for Phase 1 execution
- Next: Planner agent to fill ARCHITECTURE.md and promote Phase 1 PDF tasks into TASKS.md
```

3. Overwrite `docs/STATUS.md`:

```
**As of:** Phase 0 — Scaffolding Complete
**Last action:** Generator agent finished; npm run build passed
**Completed:** Full folder structure, all stub files, Dockerfile, docker-compose, Harness docs
**Blocked:** Nothing
**Next:** Fill ARCHITECTURE.md → begin Phase 1 PDF merge implementation
```

---

*Generator agent scope ends here. Do not begin feature implementation — that belongs to the Executor agent guided by TASKS.md.*
````



---



#### EVALUATOR.md

````markdown
# EVALUATOR.md

> **Evaluator Agent** for OfficeKit.
> This agent runs after every completed task or phase boundary. It does not write features — it audits, scores, and gates forward progress. No task moves from TASKS.md to "done" without an Evaluator pass.
>
> Read `AGENTS.md` first. Then read `STATUS.md` and the relevant `TASKS.md` entry for the work being evaluated. Execute each applicable section below in order.

---

## 0. When to Invoke the Evaluator Agent

The Evaluator agent is triggered in three situations:

| Trigger | Scope | Blocks progress? |
|---|---|---|
| **Task complete** — an Executor agent marks a TASKS.md item done | Single task | Yes — task stays "pending review" until Evaluator signs off |
| **Phase boundary** — all TODO items for a phase are marked done | Full phase | Yes — next phase does not start until phase gate passes |
| **On-demand audit** — a human or lead agent requests a check | Any scope | Advisory only |

---

## 1. Task-Level Evaluation

Run this section for every individual task completion.

### 1.1 Acceptance Criteria Check

Pull the acceptance criteria written in `TASKS.md` for the task under review. For each criterion, mark it explicitly:

```
[ ] Criterion 1 — <paste criterion text>
    Result: PASS / FAIL / PARTIAL
    Evidence: <file path, test output, or manual check note>

[ ] Criterion 2 — ...
```

A task **passes** only when every criterion is PASS. PARTIAL counts as FAIL.

### 1.2 Code Quality Checks

Run the following commands. All must exit with code 0.

```bash
# Type safety — zero errors required
npm run type-check

# Lint — zero errors required (warnings logged but do not block)
npm run lint

# Tests — all tests must pass, coverage must not regress
npm run test
```

Record the output:

```
type-check : PASS / FAIL
lint       : PASS / FAIL  (N warnings)
tests      : PASS / FAIL  (N passed, N failed, N% coverage)
```

### 1.3 Module Boundary Check

Verify the completed work respects the module boundaries defined in `docs/ARCHITECTURE.md`.

```
[ ] New code lives inside the correct src/modules/<name>/ directory
[ ] No cross-module imports (e.g. pdf/lib does not import from image/lib)
[ ] API routes only import from their own module (src/modules/<name>/lib/)
[ ] Shared utilities go into src/lib/ — not duplicated across modules
[ ] No business logic inside app/api/*/route.ts (routes are thin adapters only)
```

### 1.4 API Contract Check

For any API route touched by this task, verify against `docs/ARCHITECTURE.md`:

```
[ ] Route path matches the registered contract  (e.g. POST /api/pdf/merge)
[ ] Response shape conforms to ApiResponse<T> from src/types/api.ts
[ ] Error cases return ApiError with a meaningful error string and HTTP status
[ ] Multipart file handling uses formidable — no raw bodyParser
[ ] File size is validated against MAX_FILE_SIZE env variable
```

### 1.5 File Handling Safety Check

Any task involving file uploads or temporary files must pass:

```
[ ] Uploaded files are written to UPLOAD_DIR (from .env), not hardcoded paths
[ ] Processed output is written to OUTPUT_DIR (from .env)
[ ] Temp files are cleaned up after the response is sent (no leaks in tmp/)
[ ] File type is validated server-side (not just by extension — check magic bytes or pdf-lib parse)
[ ] File size is rejected before processing if it exceeds MAX_FILE_SIZE
```

### 1.6 Task Verdict

```
TASK VERDICT: PASS / FAIL
Blocking issues (must fix before merge):
  -
Non-blocking notes (log in LOGS.md, fix in a follow-up TODO):
  -
```

If FAIL: write the blocking issues back into `docs/TASKS.md` as sub-items on the same task and set its status back to 🔄 In Progress. Do not move it to done.

If PASS: update `docs/TASKS.md` to ✅ Done and append the verdict to `docs/LOGS.md`.

---

## 2. Phase Gate Evaluation

Run this section only at a phase boundary (all tasks for a phase are ✅ Done).

### 2.1 Completeness Check

Cross-reference `docs/TODO.md` for the phase being closed. Every item must be either ✅ Done or explicitly deferred with a reason.

```
[ ] All Phase N TODO items resolved (done or deferred with rationale)
[ ] No orphaned tasks in TASKS.md with status 🔄 In Progress
[ ] docs/STATUS.md reflects phase-end state
```

### 2.2 Integration Smoke Test

Spin up the app and manually verify the core user flow for the phase:

**Phase 1 — PDF Tools:**
```
[ ] App starts: npm run dev → no console errors
[ ] POST /api/pdf/merge — upload 2 PDFs, receive merged PDF download
[ ] POST /api/pdf/split — upload 1 PDF with range "1-2", receive split PDF
[ ] POST /api/pdf/compress — upload 1 PDF, receive smaller PDF
[ ] /tools/pdf page loads with working file upload UI
[ ] Files > MAX_FILE_SIZE are rejected with a clear error message
[ ] Invalid file types (e.g. .exe) are rejected server-side
```

**Phase 2 — Image Tools:**
```
[ ] POST /api/image/compress — upload JPG/PNG, receive compressed file
[ ] POST /api/image/convert — upload JPG, receive WebP (and vice versa)
[ ] /tools/image page loads with working UI
```

**Phase 3 — QR / Barcode:**
```
[ ] POST /api/qrcode/generate — POST with { text, type: "qr" }, receive PNG
[ ] /tools/qrcode page renders QR code preview inline
```

### 2.3 Docker Build Gate

```bash
# Must complete without errors
docker build -t officekit:phase-N-check .

# Start and verify it serves traffic
docker run --rm -p 3000:3000 officekit:phase-N-check &
sleep 5
curl -sf http://localhost:3000 | grep -q "OfficeKit" && echo "PASS" || echo "FAIL"
```

```
Docker build  : PASS / FAIL
Container boot: PASS / FAIL
HTTP response : PASS / FAIL
```

### 2.4 Performance Baseline

Run only at phase boundaries. Record results in `docs/LOGS.md` for regression tracking.

```bash
# Bundle size check — warn if > 500kB first-load JS
npm run build 2>&1 | grep "First Load JS"

# Largest file sizes in tmp/ after smoke test (check for leaks)
du -sh tmp/uploads/* tmp/outputs/* 2>/dev/null || echo "tmp/ is clean"
```

```
First Load JS  : _____ kB   (target: < 500 kB)
Largest route  : _____ kB
tmp/ leak check: CLEAN / LEAKED (list files)
```

### 2.5 Docs Completeness Check

```
[ ] docs/ARCHITECTURE.md is filled in (not just the stub)
[ ] docs/PLAN.md reflects completed phase and updated next-phase scope
[ ] docs/TODO.md has Phase (N+1) items listed and prioritized
[ ] docs/LOGS.md has entries for every non-trivial decision in this phase
[ ] README.md exists and has setup + deployment instructions
```

### 2.6 Phase Gate Verdict

```
PHASE N GATE: OPEN / BLOCKED
Blocking issues (must resolve before Phase N+1 starts):
  -
Deferred items (logged in TODO.md for Phase N+1):
  -
Evaluator sign-off: [ agent id / timestamp ]
```

If BLOCKED: list each blocking issue in `docs/TODO.md` under a "Phase N — Fixes Required" section. Do not start Phase N+1 work.

If OPEN: append the gate result to `docs/LOGS.md` and update `docs/STATUS.md` to reflect the new phase.

---

## 3. Regression Guard

Run this section whenever a task modifies a file that already passed evaluation in a prior phase (i.e. existing functionality is touched).

### 3.1 Identify Affected Surface

```bash
# List files changed in the current task branch / commit
git diff --name-only HEAD~1 HEAD
```

For each changed file, check whether it has existing tests. If not, flag it.

```
[ ] All modified src/modules/*/lib/*.ts files have corresponding tests in src/__tests__/
[ ] All modified API routes have at least one happy-path and one error-path test
[ ] No previously passing tests are now failing
```

### 3.2 Cross-Module Impact

```
[ ] Changes to src/lib/ or src/types/ do not silently break other modules
[ ] src/config/modules.ts registry is consistent with actual route availability
[ ] New "active" module in registry has a working route (not a 501 stub)
[ ] "coming-soon" modules in registry still return 501 and have not accidentally been activated
```

---

## 4. Evaluator Output Format

Every evaluation produces a structured log entry appended to `docs/LOGS.md`. Use this format:

```markdown
### [Evaluator] <Task ID or Phase N Gate> — <PASS | FAIL | BLOCKED>
- Date: YYYY-MM-DD
- Scope: task / phase-gate / on-demand
- Checks run: type-check, lint, tests, module-boundary, api-contract, file-safety, smoke-test (list applicable)
- Result summary: <one sentence>
- Blocking issues: <none | list>
- Deferred items: <none | list with TODO.md reference>
- Next recommended action: <one sentence>
```

---

## 5. Evaluator Does NOT Do

To prevent scope creep, the Evaluator agent must never:

- Write or modify feature code
- Refactor passing code for style reasons
- Add new TODO items outside of evaluation findings
- Change `docs/PLAN.md` phase scope or milestones
- Override a FAIL verdict because "it mostly works"
- Mark a task PASS if any acceptance criterion is PARTIAL

---

*Evaluator agent scope ends at the gate verdict and LOGS.md entry. Implementation fixes belong to the Executor agent.*
````



---



准备好 **PLANNER.md** + **GENERATOR.md** + **EVULUATOR.md** 后，用以下形式开始开发项目:

```text
@PLANNER_AGENT.md @GENERATOR_AGENT.md @EVALUATOR_AGENT.md 
请按三代理工作流开始开发我的个人网页项目： 
1. 先扮演 Planner，确认 Phase 1 的任务列表 
2. 再扮演 Generator，执行 T-001（初始化 Next.js 15 项目） 
3. 最后扮演 Evaluator，对生成的文件做四维评估 
技术栈：Next.js 15 + TypeScript + Tailwind CSS v4 + pnpm
```



### 四维评估摘要
A · 类型安全 : ✅ 通过（ pnpm type-check 通过）
B · 功能正确性 : ✅ 通过（ pnpm lint 、 pnpm build 通过）
C · 架构符合度 : ✅ 通过（App Router 结构保持；模块注册表集中管理）
D · 代码质量 & 可维护性 : ✅ 通过（typedRoutes 下的路由类型约束已落到 registry）
