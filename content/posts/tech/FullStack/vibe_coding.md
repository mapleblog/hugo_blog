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

###  Harness Engineering 马鞍工程

#### 1️⃣ AGENTS.md —— 最重要的入口文档

**关键认知**：第一次直觉是写一个包含所有规范、规则、历史决策的 AGENTS.md。这种做法因四个原因失败：context 是稀缺的，臃肿的指令文件挤占了实际任务；当所有内容都被标记为重要时，没有任何内容是重要的；文档会腐烂——第二周的规则到第八周就变错了；扁平文档无法被机械验证。修复方法：把 AGENTS.md 缩到 100 行。不是规则——是地图

```markdown
# 项目名称

## 项目简介
一个展示烘焙糕点和精品咖啡的品牌网站。
目标用户：本地咖啡爱好者、寻找下午茶场所的人。

## 技术栈
- HTML5 / CSS3（原生，无框架）
- 字体：[在 docs/design-system.md 中定义]
- 部署：[填你的部署方式]

## 工作流程
1. 接到任务 → 先读 docs/design-system.md
2. 改样式前 → 必须运行 `npm run lint:css`
3. 提交前 → 检查 docs/checklist.md

## 文档地图
- 设计规范 → docs/design-system.md
- 组件库 → docs/components/
- 已完成功能 → docs/exec-plans/completed/
- 进行中任务 → docs/exec-plans/active/
- 架构决策 → docs/design-docs/

## 硬性约束（不可违反）
- ❌ 不引入任何 CSS 框架（Tailwind/Bootstrap 等）
- ❌ 不修改 index.html 的语义结构，除非有明确任务
- ✅ 所有颜色必须使用 CSS 变量（定义在 :root）
- ✅ 所有间距使用 8px 倍数

## 当遇到不确定的事
- 先查 docs/ 目录
- 还不确定 → 在 exec-plans/active/ 写一份 design-doc 提案，等用户确认
```



#### 2️⃣ ARCHITECTURE.md —— 顶层领域地图

这份文档回答："这个项目在概念上由什么构成？"

```markdown
# Architecture

## 页面结构
- Hero Section（品牌门面）
- Menu Section（产品展示，分糕点 / 咖啡两类）
- Story Section（品牌故事）
- Location Section（门店信息 + 地图）
- Footer

## 数据流
- 静态页面，无后端
- 产品数据：直接写在 HTML 中（未来可能迁移到 JSON）

## 样式架构
- 全局变量层（:root 定义）
- 组件样式层（按 section 划分文件）
- 响应式层（mobile-first）

## 设计决策依据
所有"为什么这样做"的决定 → docs/design-docs/
```



#### 3️⃣ docs/design-system.md —— 视觉与交互规范

这是你 vibe coding 项目最关键的文档。把"美学方向"明确化：

```markdown
# Design System

## 品牌调性
温暖、手工感、有故事的精致。
参考：日式喫茶店 + 北欧极简的混合体。

## 色彩系统
--color-bg-primary: #FAF6F0;     /* 米白主背景 */
--color-bg-warm: #E8DDD0;        /* 烘焙暖色 */
--color-accent-coffee: #4A2C20;  /* 深咖啡棕 */
--color-accent-gold: #C8975A;    /* 焦糖金 */
--color-text-primary: #2A1F1A;
--color-text-muted: #6B5D54;

## 字体系统
- 标题：'Playfair Display', serif（衬线，优雅）
- 正文：'Inter', sans-serif（清晰易读）
- 中文：'Noto Serif SC', serif

## 间距尺度
基础单位 8px：4 / 8 / 16 / 24 / 32 / 48 / 64 / 96 / 128

## 交互规范
- 所有可点击元素 → cursor: pointer + hover 状态
- 过渡时长统一 0.3s ease
- 不使用突兀的弹出动画，偏好淡入淡出

## 禁忌
- ❌ 鲜艳的纯红、纯蓝
- ❌ 圆角超过 12px（不要太"科技感"）
- ❌ 阴影过重（要轻盈）
```





#### 4️⃣ docs/exec-plans/ —— 任务执行计划

每个具体任务（比如"为 Hero Section 添加样式"）写成一个 markdown 文件，放在 `active/`，完成后移到 `completed/`
```markdown
# exec-plan: Hero Section 视觉设计

## 目标
给现有的 Hero HTML 骨架添加视觉样式，传达品牌温暖手工感。

## 验收标准
- [ ] 移动端、平板、桌面三档断点正常
- [ ] 主标题字体加载完成前有合理 fallback
- [ ] 背景图加载失败有降级方案
- [ ] 通过 lint:css 检查
- [ ] Lighthouse 性能分数 ≥ 90

## 涉及文件
- index.html（仅可能修改 class 名）
- css/sections/hero.css（新建）

## 不在范围内
- 不处理 Menu 部分
- 不添加 JS 交互
```





#### 5️⃣ 机械化约束（这是 Harness 与普通文档的根本区别）

仅有文档不足以保持完全由 agent 生成的代码库的一致性。通过强制不变量（invariants）而非微管理实现，让 agent 能快速发布而不破坏基础。 [OpenAI](https://openai.com/index/harness-engineering/)

具体来说，给你的项目加：

**`.editorconfig`** —— 强制缩进、换行 **`stylelint.config.js`** —— 强制 CSS 规则（比如禁用某些颜色值、强制使用 CSS 变量） **`package.json` scripts**：

```json

```













#### **Shadcn/ui 底层组件原语库**

| 场景                     | 推荐        |
| ------------------------ | ----------- |
| 已有 Radix 项目、求稳    | **Radix**   |
| 全新项目、看重长期维护   | **Base UI** |
| 需要大量社区资源/示例    | **Radix**   |
| 追求更小体积、更现代 API | **Base UI** |



#### Radix | Base UI 视觉风格预设

| 预设   | 风格描述                                 | 适合场景                 |
| ------ | ---------------------------------------- | ------------------------ |
| Nova   | 现代简洁，默认图标用 Lucide + Geist 字体 | 通用 SaaS、工具类应用    |
| Vega   | 经典 shadcn/ui 原版风格                  | 熟悉的传统 shadcn 外观   |
| Maia   | 柔和圆润，圆角更大                       | 面向消费者的产品、友好感 |
| Lyra   | 方正锐利，棱角分明                       | 技术感强、开发者工具     |
| Mira   | 紧凑密集，信息密度高                     | 数据密集型界面、后台管理 |
| Luma   | 明亮轻盈                                 | 内容类、轻量应用         |
| Custom | 完全自定义                               | 有设计稿或品牌规范       |



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
5. **技术栈约束**	--> 让claude opus 根据自己要开发的网站类型生成适合的约束
6. **设计模式**
7. **代码规范性**	--> 让claude opus 根据自己要开发的网站类型生成适合的约束
8. **安全保护机制**	--> 让claude opus 根据自己要开发的网站类型生成适合的约束
8. **MVP或者MVE**
9. **测试框架**
10. **mock数据连接真实后端测试** 先 Mock 后真实 (阶段式推进，推荐)
  
同时也需要麻烦你考量这个项目是否需要：
- 需要判断受否需要后期扩展声明（PRD预留接口），方便后期新功能开发
- 需要声明代码规范性规则，确保代码结构一致性
- 采用适合对项目的安全保护机制
  
当我回答完问题后。请在当前路径以**英文**生成完整详细的Phase_1_PRD.md。

```



> [!TIP]
>
> ## **测试框架**
> **不需要测试** 框架的场景: 
>
> - **个人博客、静态展示页**：内容为主，逻辑简单，改坏了自己知道
> - **一次性活动页、营销落地页**：生命周期短，上线就归档
> - **原型验证/Demo**：目标是验证想法，测试拖慢迭代
> - **小型工具站**（如单页面的颜色选择器）：功能单一，手动测试足够
> - **学习练习项目**：重点是学新技术
>
> **需要测试 **框架的场景: 
>
> - **涉及金钱交易**（支付、账户余额）
> - **涉及用户数据持久化**（数据丢了用户就炸）
> - **涉及法律合规**（医疗、金融、隐私）
> - **多人协作的长期项目**（别人改代码你不知道有没有破坏你的功能）
> - **核心算法复杂**（AI 推荐、推送、调度）
> - **涉及安全/生命安全**（就是你这个项目）



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
