+++
title = 'Claude Harness'
date = 2026-02-02T12:49:14+08:00
draft = false
slug = "832522f"
description = ""
summary = ""
tags = [ "代码", "开发" ]
categories = [ "code" ]
cover = ""
author = "MapleScraps"



---



## Harness Engineering

#### PLANNER.md / AGENTS.md

[参考 **AGENTS.md** 文档](C:\Users\tkgoh\OneDrive\Personal\AI\Claude Harness\Harness Engineering 10.05.2026\AGENTS.md)

---


这份文件的结构设计是**刻意的、有逻辑的**

这份 AGENTS.md 的核心定位是"**每个 Agent 第一个读的文件**"。
它的章节顺序完全对应一个 Agent 的**认知加载顺序**：

```
1. 我在做什么项目？          → Section 1: Project Overview
2. 我该去哪里找信息？        → Section 2: Document Map
3. 我该怎么行动？            → Section 3: Agent Workflow
4. 我更新文档要遵守什么规则？ → Section 4: Update Rules
5. 我要用什么命令执行操作？   → Section 5: Commands & Tooling
```

每一节都是下一节的**前提**——Agent 必须先知道项目是什么，才能理解文档地图；先理解文档地图，才能走工作流；先走工作流，才需要知道更新规则；最后才是具体命令。



---



### 如果有新项目开发，需要改的地方有 **4 处**，其余全部可以复用：

**必须改：**

**§1 Project Overview** — 项目名、描述、技术栈、部署方式、发布策略、当前阶段。这是你说的那部分，没错。

**§5 Commands & Tooling** — 如果 ToDoList 用不同的包管理器（比如 pnpm）、不同的测试框架、或者不需要 Docker，命令要对应调整。如果技术栈一样就不用动。

------


### **可以直接复用（不用改）：**

- §2 Document Map 的表格结构和七层文档职责 — 这是 Harness 工作流本身，与项目无关
- §3 Agent Workflow 的 Orient → Plan → Pick → Execute → Record → Hand off → Deploy 七步 — 普适流程
- §4 Update Rules 的所有规则 — 文档更新纪律与项目内容无关
- §2 里的 ASCII 架构图 — 三层结构不变
  

------


**一个判断原则：**

> §1 描述"这个项目是什么"，其余章节描述"我们如何做项目" —— 后者是方法论，天然跨项目复用。

所以 AGENTS.md 可以理解为一个**模板**，每个新项目只需填写 §1 + 核对 §5 命令，5 分钟就能完成新项目的 master index。



---



### Harness Engineering **AGENTS.md** 来生成 **GENERATOR.md** + **EVALUATOR.md**

```text
对于小白需要自己修改简直是一个噩梦，我好奇你原本创建的GENERATOR.md 和 EVALUATOR.md 和 DEPLOYER.md 是不是根据 AGENTS.md 来生成的？还是你用其他方式生成？
```

直接回答：**是的，完全根据 AGENTS.md 的内容生成的。**

具体来说，我当时的生成逻辑是：

- 读取 AGENTS.md 的 §1（项目名 OfficeKit、技术栈、模块列表、部署方式）
- 把这些信息"硬编码"进了 GENERATOR.md / EVALUATOR.md / DEPLOYER.md 的具体内容里

------

**这就是问题所在。**

正确的做法应该是：

**GENERATOR.md / EVALUATOR.md / DEPLOYER.md 本身不应该包含任何项目特定信息**，它们应该是纯流程文档，所有项目细节都通过读取 AGENTS.md 动态获取。

也就是说，三份文档开头应该声明：

```
> 执行前必须读取 AGENTS.md，
> 所有项目名称、模块列表、技术栈、命令
> 均从 AGENTS.md §1 和 §5 中获取，
> 本文档不硬编码任何项目特定信息。
```

这样换新项目时，你只需要改 **AGENTS.md** 一份文件，其他三份完全不用动。



---



```text
假设我已经在AGENTS.md编辑成新项目的信息，那么我应该如何正确告诉claude根据我的编辑的AGENTS.md文档生成GENERATOR.md / EVALUATOR.md / DEPLOYER.md？
```

给你一个可以直接复制粘贴到 Claude 对话框的提示词：

------

```
我有一份已经填写好的 AGENTS.md，请你根据这份文档的内容，
为我生成配套的三份代理文档：GENERATOR.md、EVALUATOR.md、DEPLOYER.md。

生成规则：
1. 所有项目名称、模块列表、技术栈、目录结构、命令、部署方式
   全部从我提供的 AGENTS.md 中读取，不要假设或沿用其他项目的内容
2. 三份文档不硬编码任何项目特定信息——
   凡是项目细节都注明"来自 AGENTS.md §X"的引用来源
3. 生成顺序：GENERATOR.md → EVALUATOR.md → DEPLOYER.md
4. 每份文档生成完毕后暂停，等我确认没问题再继续下一份

这是我的 #AGENTS.md

```



**使用步骤就三步：**

1. 复制上面的提示词
2. 把 `[把你的 AGENTS.md 全文粘贴在这里]` 替换成你实际的 AGENTS.md 内容
3. 粘贴到 Claude 对话框发送

**关键是"每份生成后暂停确认"这一句**，避免三份一口气生成完你发现第一份有问题又要全部重来。如果你觉得不需要逐份确认，把那句删掉就行。



---



#### GENERATOR.md 

[参考 **GENERATOR.md** 文档](C:\Users\tkgoh\OneDrive\Personal\AI\Claude Harness\Harness Engineering 10.05.2026\GENERATOR.md)

这份文档和项目结构深度绑定，以下部分必须改：

**§1 Scaffold** — 如果 ToDoList 不需要 `--src-dir` 或其他 create-next-app 参数，调整初始化命令。

**§2 Install Dependencies** — OfficeKit 装了 `pdf-lib`、`sharp`、`formidable`、`qrcode`，ToDoList 完全不需要这些。换成 ToDoList 实际需要的包，比如数据库客户端（`prisma`、`sqlite3`）、状态管理等。

**§3 Create Folder Structure** — 这是改动最大的地方。OfficeKit 的 `src/modules/pdf/`、`src/modules/image/`、`src/modules/qrcode/` 全部要换成 ToDoList 的目录结构，比如 `src/modules/tasks/`、`src/modules/lists/` 等。

**§4 Placeholder Files** — 所有 stub 文件的路径和内容都跟模块名绑定，需要完全重写。`modules.ts` 的 MODULES 注册表也要换成 ToDoList 的功能条目。

**§5 Environment & Config** — `.env.example` 里的变量要换，`next.config.ts` 的 `bodySizeLimit` ToDoList 可能不需要，Dockerfile 和 docker-compose 基本可以复用。

**§7 Verification** — 预期目录树要改成 ToDoList 的实际结构。



---



#### EVALUATOR.md

[参考 **EVALUATOR.md** 文档](C:\Users\tkgoh\Documents\Github\hugo_blog\content\docs\EVALUATOR.md)

这份文档大部分是评估方法论，跨项目通用。只有以下两处需要改：

**§3 维度 B 的文件处理安全专项** — OfficeKit 特有的（tmp/ 清理、magic bytes、MAX_FILE_SIZE）。ToDoList 没有文件上传，这整块可以删掉或替换为 ToDoList 对应的安全检查（比如输入校验、XSS 防护）。

**§9 Phase Gate 的 Smoke Test** — 目前写的是 PDF/Image/QR 三个 Phase 的具体操作路径，要换成 ToDoList 各 Phase 的验收操作，比如"创建一条 Todo"、"标记完成"、"过滤列表"等。

其余全部 —— 四维评估标准表、EVAL_REPORT 格式、FIX/ESCALATE 决策指令、轮次上限、LOGS.md 格式、Deployer 交棒声明、文档写权限表 —— **全部可以直接复用，一字不改**。



---

### Trae 规则里配置

```markdown
1. 每一次开始新的对话，必须阅读：
#AGENTS.md, #GENERATOR.md, #EVALUATOR.md，#DEPLOYER.md，#DESIGN.md 遵从这五份文档工作流。

2. 执行任何 UI 组件、页面、样式相关任务时，
必须自动加载 #DESIGN.md 作为设计依据。
```



### 准备好 **PLANNER.md** + **GENERATOR.md** + **EVULUATOR.md** 后，第一次对话用以下形式开始开发项目:

```text

#AGENT.md #GENERATOR.md #EVALUATOR.md  #DEPLOYER.md
请按四代理工作流开始开发我的个人网页项目： 
1. 依照 #AGENT.md 中的 ## 2. Document Map & Responsibilities 创建文档
2. 扮演 Generator，初始化 Next.js 15 项目
3. 最后扮演 Evaluator，对生成的文件做四维评估 
技术栈：Next.js 15 + TypeScript + Tailwind CSS v4 + pnpm



---

#AGENTS.md #GENERATOR.md #EVALUATOR.md #DEPLOYER.md
请按三代理工作流开始开发我的个人网页项目： 
我想开发pdfs合并功能模块，你可以和我进行沟通获取你认为需要的信息，然后请用 **T-00x** 形式拆解任务。然后记录到**TASKS.md**

@TASKS.md, @LOGS.md, STATUS.md 已经更新了吗？

---

claude原提示词
# @PLANNER_AGENT.md @GENERATOR_AGENT.md @EVALUATOR_AGENT.md 
# 请按三代理工作流开始开发我的个人网页项目： 
# 1. 先扮演 Planner，确认 Phase 1 的任务列表 
# 2. 再扮演 Generator，执行 T-001（初始化 Next.js 15 项目） 
# 3. 最后扮演 Evaluator，对生成的文件做四维评估 
# 技术栈：Next.js 15 + TypeScript + Tailwind CSS v4 + pnpm

```



---



### Harness Engineering 添加新功能提示词

```text
pdf合并功能已经完成，功能测试也正常。
接下来我想开发pdf拆分功能，先和我进行沟通然后进行拆分任务，将拆分任务记录到TASKS.md

```



---

### Harness Engineering 添加网页设计风格和样式

职责分离原则：

```
GENERATOR.md  → 负责"建什么文件夹、装什么包、生成什么骨架"
DESIGN.md     → 负责"网站长什么样、用什么色彩、什么字体、什么交互效果"
```

GENERATOR.md 只需要在末尾加一行引用：

```
执行 UI 相关任务前，必须先读取 DESIGN.md 获取设计规范。
```

------

**DESIGN.md 的标准结构建议：**

```
# DESIGN.md

## 1. 设计风格定义
   整体风格（极简/玻璃态/新拟态/企业级/暗黑...）

## 2. 色彩系统
   主色、辅色、背景色、文字色、危险色 — 用 CSS 变量定义

## 3. 字体系统
   标题字体、正文字体、等宽字体、字号阶梯

## 4. 间距 & 布局
   容器宽度、栅格、内外边距规则

## 5. 组件规范
   Button、Card、Input、Modal 等核心组件的样式规则

## 6. 动效规范
   过渡时长、缓动曲线、hover/focus 效果

## 7. 响应式断点
   mobile / tablet / desktop 的布局切换规则

## 8. 禁止事项
   不允许出现的样式写法（如禁止任意值 w-[347px]）
```

可以参考Deekseek 提供的网页元素清单：[Website Elements List](C:\Users\tkgoh\OneDrive\Personal\AI\Claude Harness\Harness Engineering 10.05.2026\sub_docs\Web Element Design.md)

------

**你不需要写代码，只需要用自然语言描述风格**，比如：

```
整体风格：极简白色背景，卡片投影，圆角 12px
主色：#3B82F6（蓝色）
按钮：实心主色，hover 加深 10%，点击有轻微缩放效果
动效：所有过渡 200ms ease-in-out
禁止使用任意 Tailwind 值如 w-[347px]
```

**情况一：第一次生成页面**

```
#AGENTS.md #DESIGN.md

请根据 DESIGN.md 的设计规范，为 /tools/pdf 页面生成 UI。

页面需要包含：
- 文件上传区域（支持拖拽）
- 已上传文件列表
- 操作按钮（合并/拆分/压缩）

不需要我解释颜色和样式，直接从 DESIGN.md 读取规范来实现。
```

------

**情况二：觉得某个地方不好看，想调整**

```
#DESIGN.md

我觉得当前的按钮看起来太重了，能不能改得更轻一点？
请参考 DESIGN.md 的 §7.1 Button 规范来调整，
不要使用 DESIGN.md 禁止事项里的样式。
```

------

**情况三：想新增一个组件但不知道怎么写**

```
#DESIGN.md

请帮我新建一个文件上传拖拽区域的组件 DropZone，
路径放在 src/components/ui/DropZone.tsx。

风格要求：直接按照 DESIGN.md 来，我不懂 CSS，
你负责保证它符合 MUJI 极简风格就好。
```

------

**核心原则只有一句话：**

> 你不需要懂设计，只需要告诉 Claude **"页面要有什么内容"**，然后加上 `#DESIGN.md`，Claude 会自己查规范决定怎么呈现。

你负责说"做什么"，DESIGN.md 负责说"怎么好看"。



---



### 四维评估摘要
A · 类型安全 : ✅ 通过（ pnpm type-check 通过）
B · 功能正确性 : ✅ 通过（ pnpm lint 、 pnpm build 通过）
C · 架构符合度 : ✅ 通过（App Router 结构保持；模块注册表集中管理）
D · 代码质量 & 可维护性 : ✅ 通过（typedRoutes 下的路由类型约束已落到 registry）



---

### DESIGN.md (模板)



### MIGRATION.md

[MIGRATION.md](C:\Users\tkgoh\OneDrive\Personal\AI\Claude Harness\Harness Engineering 10.05.2026\MIGRATION.md)

------

```
#AGENTS.md #MIGRATION.md

你是 OfficeKit 项目的 Migration 代理。

我已经将项目代码拷贝到新服务器上，
服务器系统是 Ubuntu 22.04，
项目目录在：[填写实际路径，如 /home/deploy/apps/officekit]

请从 MIGRATION.md 的 §1 开始执行，跳过 §0（旧服务器备份已完成）。

## 我已经完成的步骤（跳过这些）
- [x] 代码已拷贝到服务器

## 请按顺序执行以下章节
- §1 新服务器初始化（防火墙、fail2ban、deploy 用户）
- §2 安装运行环境（Node.js 20、Docker、Nginx、Certbot）
- §3 跳过（代码已在服务器上，无需 git clone）
- §4 环境配置（.env.local、tmp 目录）
- §5 安装依赖并构建（npm ci、npm audit、npm run build）
- §6 Docker 部署
- §7 Nginx 反向代理配置
- §8 SSL 证书申请

## 需要我提供的信息
在执行 §4 时暂停，询问我 .env.local 的内容。
在执行 §7 时暂停，询问我的实际域名。
在执行 §8 时暂停，询问我的邮箱地址。

每个章节执行完毕后输出该章节的检查清单结果，
确认全部通过后再继续下一章节。
```

------

**使用前替换两处内容：**

```
[填写实际路径]  →  你的项目实际目录，如 /home/deploy/apps/officekit
```

------

**执行过程中 Claude 会在三个地方主动暂停等你输入：**

```
§4  → 询问 .env.local 的内容（你之前备份的那份）
§7  → 询问你的域名（如 officekit.yourdomain.com）
§8  → 询问你的邮箱（用于 Let's Encrypt 证书）
```

其余步骤 Claude 会自动按 MIGRATION.md 的命令顺序执行，每章节完成后输出检查清单结果再继续。

