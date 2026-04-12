+++
title = 'Vibe Coding'
date = 2026-01-29T17:27:52+08:00
draft = true
slug = "1d8fda6"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"

+++

### 前后端API 连贯推荐

| 前端              | 后端 API                  |
| ----------------- | ------------------------- |
| HTML + JavaScript | Node.js + Express         |
| Next.js           | Python + FastAPI + Jinja2 |
|                   |                           |





### 1. 如何准备高效完整的Vibe Code PRD？

- 使用 `prd` [prd](https://1drv.ms/f/c/00e6faf8d8fbf187/IgCFrotoKC_CRpL7e0tagDl2AXO5SoteFBKK01_C_GRJjbo?e=JDEg7E) skill 生成？
- 使用 claude 生成？





#### MVE （Minimum Viable Experience） or MVP（Minimum Viable Product）


| 维度      | **MVE (最小可行性体验)**          | **MVP (最小可行性产品)**       |
| --------- | --------------------------------- | ------------------------------ |
| 首要目标  | 捕获用户的“哇塞”时刻              | 验证用户是否愿意支付/持续使用  |
| Vibe 核心 | **视觉 & 动效** (Visuals & Flow)  | **逻辑 & 数据** (Logic & Data) |
| 典型项目  | AI 艺术生成器、个性化主页、小游戏 | SaaS 订阅工具、CRM、自动化脚本 |
| 失败标志  | 用户觉得“无聊”                    | 用户觉得“不可用/有 Bug”        |



#### 编写提示词的快速方法

1. 逆向提问（Reverse Prompting）
- 直接让 AI 问你
- 你可以给 AI 发这样一句话：

```markdown

我想制作一个[项目名]，需要准备一份PRD的vibe code提示词模板，我是一个不懂技术细节的创始人，目标是建立[简单的项目需求描述]’。请你扮演多年经验的资深全栈工程师 + Vibe Coding 专家，使用 RCC + SCF / RELIC + ICIO 组合框架。 

技术栈： Next.js + Typrscript + Tailwind CSS + Shadcn/ui + Prisma
  
为了让你更好的写出vibe coding提示词，你可以向我提问挖掘你所有需要的:
1. **项目细节**
2. **项目核心需求**
3. **画出/列出数据结构**
4. **定义视觉风格**
5. **技术栈约束**
6. **设计模式**
7. **规范要求**
8. **MVP或者MVE**
9. **测试框架**
10. **mock数据连接真实后端测试**
  
同时也需要麻烦你考量这个项目是否需要：
- 需要判断受否需要后期扩展声明，方便后期新功能开发
- 需要声明代码规范性规则，确保代码结构一致性
- 采用适合对项目的安全保护机制
  
当我回答完问题后。请在当前路径以**英文**生成完整详细的Phase_1_PRD.md。

```



## 🎨 Vibe Code UI/UX 提示词模板

```markdown
请帮我设计一个 [页面类型]，风格是 [视觉风格关键词]。

【核心信息】
- 用途：[这个页面是用来做什么的]
- 目标用户：[谁会使用它]
- 设备：[桌面端 / 移动端 / 两者兼顾]

【视觉风格】
- 整体氛围：[关键词，见下方词汇表]
- 配色方案：[主色 + 辅助色，或直接描述感觉]
- 字体感觉：[见下方选项]
- 留白处理：[宽松 / 紧凑 / 极简]
- 动效偏好：[无 / 微动效 / 丰富动画]

【布局与内容】
- 主要模块：[列出页面要有哪些区块]
- 强调重点：[哪个部分最重要，需要突出]
- 特殊交互：[悬停效果 / 滚动动画 / 点击反馈 等]

【技术要求】
- 输出格式：单文件 HTML（含 CSS 和 JS）
- 不使用外部框架（或：可以使用 Tailwind / Chart.js 等）
```



![webpage_standard_structure](C:\hugo\my_hugo\public\images\webpage_standard_structure.svg)

[](C:\hugo\my_hugo\public\images\landing_vs_login_comparison.svg)





## 单页应用（Single Page）+ 锚点滚动

```markdown
中文版提示词：
我想创建一个"烘培咖啡"单页网站，不需要路由跳转。页面顶部有固定导航栏，包含四个菜单项：Home、Menu、About Us、Contact。点击任意菜单项时，页面平滑滚动到对应的内容区块（使用锚点 #home #menu #about #contact）。所有内容区块都在同一个 HTML 页面上垂直排列，每个区块高度至少 100vh。导航栏始终固定在顶部，当前所在区块对应的菜单项高亮显示（使用 IntersectionObserver 实现）。

只输出一个 index.html 文件。不使用任何框架、不需要 npm 安装、不需要构建工具。所有 HTML、CSS、JavaScript 写在同一个文件里。禁止使用 React、Next.js 或任何组件化框架。


英文版提示词（给 Cursor / Bolt / v0 效果更好）：
Build a single-page website with no routing. The page has a fixed top navbar with four links: Home, Menu, About Us, and Contact. Clicking each link smoothly scrolls to the corresponding section on the same page using anchor IDs (#home, #menu, #about, #contact). All sections are stacked vertically in one HTML file, each at least 100vh tall. The navbar stays fixed at the top, and the active nav item updates automatically as the user scrolls, using IntersectionObserver.

Output a single index.html file only. No frameworks, no npm, no build tools. Pure HTML, CSS, and vanilla JavaScript in one file. Do not use React, Next.js, or any component-based framework.

```

**几个关键词的作用：**

- `single-page` / `单页` — 告诉 AI 不要生成多个 HTML 文件或配置路由
- `anchor IDs` / `锚点` — 指定用 `#id` 跳转而不是页面跳转
- `smooth scroll` / `平滑滚动` — 避免生硬的瞬间跳转
- `fixed navbar` / `固定导航栏` — 滚动时菜单不消失
- `IntersectionObserver` — 让当前菜单项自动高亮，不加这个 AI 经常漏掉

**如果你还想进一步定制，可以追加：**

> 使用 Tailwind CSS 做样式，字体用 Inter，配色主色调为深绿色 `#1a3c2e`，背景为米白色 `#faf8f3`。



-----

我需要你仔细阅读这份PRD文档,然后进行第二部"项目基础架构配置安装与部署"。同样使用**结构化上下文框架 (Structured Context Framework)** 结合 **Role-Context-Constraints (RCC)** 写出最完美的生产级提示词，请作为资深全栈工程师和vibe code专家向我提问，挖掘你所有需要的技术细节和业务需求，直到你认为可以开始写提示词为止。最后以**英文**生成完整详细的.md文件🆗

-----

> [!TIP]
>
> **Product Requirement Document**
>
> - skills --> PRD



> [!TIP]
>
> **Frontend Setup Document**	前端架构草稿
>
> - skills --> nextjs-setup
> - skills --> 
>
> **Frontend Deployment / Build** 
>
> - skills --> nextjs-app-router-patterns
>
> **Frontend Performance Check**
>
> - skills --> nextjs-performance
>
> **Frontend Architecture Check**
>
> - skills --> 
>
> **Frontend Security Check**
>
> - skills --> frontend-security
> - 



> [!TIP]
>
> **Database Setup Document**
>
> - skills --> database-migrations
>
> **Database Deployment / Build**
>
> - skills --> prisma-database-setup
>
> **Database Security Check**
>
> - skills --> database-security
> - 



> [!TIP]
>
> **Token & Oauth**
>
> - Oauth 登陆界面文档
>   建议 skills --> nextjs-supabase-auth
> - Oauth 登陆界面开发
>   建议 skills --> 
>
> - Oauth 登陆界面检查
>   建议 skills --> 
>
> - Oauth 登陆界面测试
>   建议 skills --> 
> - 安全性 Token 验证 & 注册登录
>   建议 skills --> 



> [!TIP]
>
> **API Endpoint**
>
> - 开发 API 端点
>   建议 skills --> 
> - 



> [!TIP]
>
> **UI/UX Frontend Design Document**
>
> - skills --> ui/ux-pro-max
>
> **UI/UX Frontend Design Deployment**
>
> - skills --> ui/ux-pro-max
> - 



> [!TIP]
>
> **Backend Setup Document**
>
> - skills --> backend-patterns
>
> **Backend Deployment / Build**
>
> - skills --> web-backend
>
> **Backend Architecture Check**
>
> - skills --> backend-patterns
>
> **Backend Architecture Testing**
>
> - skills --> 
>
> **Backend Security Check**
>
> - skills --> backend-security
> - 



> [!TIP]
>
> - **单元/集成测试**：**Vitest**	# 业务逻辑、API Route、工具函数
> - **组件测试**：**Vitest + Testing Library**	# React 组件渲染和交互
> - **数据库测试**：**Vitest + Prisma**	# 配合测试数据库或 mock
> - **E2E 测试**：**Playwright**	# 全链路用户流程测试



| 阶段               | 步骤名称                            | 说明                                                         |
| ------------------ | ----------------------------------- | ------------------------------------------------------------ |
| **第一阶段：地基** | **1. 拟定项目需求 (PRD)**           | 明确“我们要造什么”，给 AI 提供清晰的上下文。                 |
|                    | **2. 项目基础配置安装与部署**       | 初始化仓库、选择框架（Next.js/Python等）、配置环境变量。     |
| **第二阶段：骨架** | **3. 数据库建模 (DB Schema)**       | **核心步骤**。先让 AI 确定数据长什么样，后续的 API 和 UI 才不会乱。 |
|                    | **4. 搭建后端基础架构**             | 确定目录结构、连接数据库、配置基础中间件。                   |
| **第三阶段：逻辑** | **5. 开发 API 端点 (CRUD)**         | 编写核心业务逻辑接口。                                       |
|                    | **6. 安全性 Token 验证 & 注册登录** | 将身份验证集成到 API 层，确保数据安全。                      |
| **第四阶段：皮囊** | **7. UI/UX 前端页面开发**           | 基于已有的 API 渲染数据，利用 AI 快速生成组件。              |
| **第五阶段：发布** | **8. 部署项目到线上**               | 尽早部署（CI/CD），在真实环境下测试性能和 Bug。              |
| **第六阶段：进化** | **9. 后期扩展与迭代**               | 根据反馈增加新模块或优化体验。                               |



---


如果你想让下一个项目顺利落地，请尝试这个顺序：

#### 第一步：先画一张“地图” (The Schema)

不要直接写代码。先用中文告诉 AI：**“我要做一个 [XXX] 应用，它的核心数据模型（Schema）应该长什么样？请给我列出字段名和类型。”**

> **核心逻辑：** 数据库就是项目的“真理来源”。只要这一步定了，AI 后面写代码都会参考这个标准，不会乱起名字。





#### 第二步：搞定“身份办证”（Authentication）

在 UI 还没变复杂之前，先把 **注册/登录** 做掉。

> **核心逻辑：** 登录系统像房子的地基。先打好地基，再往里搬家具（功能模块），你会发现权限控制（比如：只有我能删我的贴子）写起来非常顺滑，不用后期到处打补丁。



#### 第三步：从“后端接口”到“前端交互”（Inside-Out）

让 AI 先写一个简单的 API（比如：保存一条笔记），然后再写前端页面去调用这个 API。

> **核心逻辑：** 这样你看到的就是**真实的数据**在流动，而不是一堆假图片和假文字。



#### 第四步：美化与抛光（The Vibe）

最后再去磨 UI 的细节、动画和颜色。

> **核心逻辑：** 这时候数据逻辑已经是稳的了，你可以随心所欲地让 AI 改界面风格，而不用担心把功能改坏。



### 知识库

- GTD 是什么？
- TBD 是什么？



### 想法验证

1. 准备好项目需求文档，声明网站语言
2. 规划网站的区块布局架构
3. 规划网站区块内容
4. 声明技术栈，要求根据项目准备标准结构化
5. 声明从header / navbar 开发，进行调整，样式效果，设计风格，字体样式，动态效果
6. 区块逐一开发，navbar / header -> hero / banner -> main content -> side bar -> footer 包括样式，风格？
