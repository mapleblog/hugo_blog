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

# Vibe Coding 流程
1. PRD构建
   - 使用 `prd` [prd](https://1drv.ms/f/c/00e6faf8d8fbf187/IgCFrotoKC_CRpL7e0tagDl2AXO5SoteFBKK01_C_GRJjbo?e=JDEg7E) skill 生成？
   - 使用 claude 生成？
2. 项目基础架构配置安装与部署
   - 使用什么 skill ?
3. 数据库架构配置安装与部署
   - 使用 [designing-database-schemas](https://skillsmp.com/skills/jeremylongshore-claude-code-plugins-plus-skills-backups-skills-migration-20251108-070147-plugins-database-database-schema-designer-skills-database-schema-designer-skill-md) skill 
4. 后端基础架构配置安装与部署
   - 使用什么 skill ?
5. 开发 API 端点
   - 使用什么 skill ?
6. 安全性 Token 验证 & 注册登录
   - 使用什么 skill ?
7. UI/UX 前端页面开发
   - 使用 [artifacts](https://skillsmp.com/skills/muath2000-tradestation-claude-skills-web-artifacts-builder-skill-md)，[frontend-design](https://skillsmp.com/skills/anthropics-skills-skills-frontend-design-skill-md)，[penpot-uiux-design](https://skillsmp.com/skills/github-awesome-copilot-skills-penpot-uiux-design-skill-md) skill 
   - 
8. 项目线上部署
   - 使用什么 skill ?
9. 后期扩展与迭代
   - 使用什么 skill ?
10. 框架测试
    - 使用 [vitest-test-creator](https://skillsmp.com/skills/jeremylongshore-claude-code-plugins-plus-skills-skills-09-test-automation-vitest-test-creator-skill-md)
    - 



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

技术栈： Next.js + Tailwind CSS + Shadcn/ui + Supabase
  
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
> - 
> - 



> [!TIP]
>
> **API Endpoint**
>
> - 
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
> 



1. Oauth 登陆界面文档
   建议 skills --> nextjs-supabase-auth

2. Oauth 登陆界面开发
   建议 skills --> 

3. Oauth 登陆界面检查
   建议 skills --> 

4. Oauth 登陆界面测试
   建议 skills --> 

   

   

5. 开发 API 端点
   建议 skills --> 

6. 安全性 Token 验证 & 注册登录

7. UI/UX 前端页面开发
8. 项目线上部署
9. 后期扩展与迭代
10. 框架测试
=======

7. UI/UX 前端页面设计方案选择文档
   建议 skills --> ui-ux-pro-max

8. UI/UX 前端页面设计开发
   建议 skills --> ui-ux-pro-max

9. 项目线上部署

10. 后期扩展与迭代



  反问技巧：

  ```text
  AI 会提供系统化的问题要求用户回答，接下来再将AI系统化问题要求 claude / gemini 以 [资深前端工程师 / vide code 专家] 提供详细答案。
  最后将回答给回提问的AI 
  
  ```

> [!TIP]+ 
>
> # 📋 PRD Vibe Code 提示词完整模板
>
> 我想制作一个**[项目名称]**，需要准备一份 PRD 的 Vibe Code 提示词。我是一个不懂技术细节的创始人，目标是建立**[一句话项目需求描述]**。
>
> 请你扮演多年经验的**资深全栈工程师 + Vibe Coding 专家**，使用 **RCC + SCF 组合框架**帮我完成需求分析和技术方案设计。
>
> **基础技术栈**：Next.js (App Router), Prisma, Tailwind CSS
>
> ---
>
> ## 🔍 第一步：需求挖掘（请逐项向我提问）
>
> ### 1. 项目细节
> **请问我：**
> - 这个项目解决什么问题？目标用户是谁？
> - 有没有类似的参考产品？（提供网址或截图）
> - 预计的用户规模？（< 100 / 100-1000 / 1000+ ）
>
> **我的回答：**
> ````
> [在此填写]
> ````
>
> ---
>
> ### 2. 核心功能需求
> **请问我：**
> - 列出 3-5 个**必须有**的核心功能（MVP 范围）
> - 哪些功能是「有更好，没有也行」的次要功能？
> - 有没有特殊的业务逻辑或规则？
>
> **我的回答：**
> ````
> 核心功能（P0 - 必须有）：
> 1. 
> 2. 
> 3. 
> 
> 次要功能（P1 - 重要但非必需）：
> 1. 
> 2. 
> 
> 业务规则：
> - 
> ````
>
> ---
>
> ### 3. 数据结构设计
> **请问我：**
> - 核心实体有哪些？（如：用户、订单、文章、评论）
> - 实体之间的关系？（一对一 / 一对多 / 多对多）
> - 每个实体的关键字段？（我会帮你补充技术细节）
> - 是否需要软删除（逻辑删除）？是否需要审计日志（创建时间/更新时间/操作人）？
>
> **我的回答：**
> ````
> 实体列表：
> 1. [实体名] - 关键字段：___、___、___
> 2. [实体名] - 关键字段：___、___、___
> 
> 关系说明：
> - [实体A] 和 [实体B] 是 [1对1 / 1对多 / 多对多] 关系
> 
> 特殊需求：
> - [ ] 需要软删除
> - [ ] 需要审计日志（createdAt, updatedAt, createdBy）
> ````
>
> ---
>
> ### 4. 视觉风格定义
> **请问我：**
> - 整体风格偏好？（现代简约 / 传统商务 / 创意活泼 / 极简主义）
> - 主色调？（如：蓝色科技感、绿色自然风、紫色创意风）
> - 参考网站或设计系统？（如：Stripe、Linear、Notion、Airbnb）
> - 移动端优先还是桌面端优先？
>
> **我的回答：**
> ````
> 风格：[选择一个]
> 主色调：[颜色 + 感觉]
> 参考网站：[网址或描述]
> 优先级：[ ] 移动端优先  [ ] 桌面端优先  [ ] 响应式（都重要）
> ````
>
> ---
>
> ### 5. 技术栈补充确认
> **请问我：**
> - **数据库**：PostgreSQL / MySQL / SQLite / MongoDB？
> - **认证方案**：需要用户登录吗？
>   - 如需要 → NextAuth.js / Clerk / Supabase Auth / 自建？
> - **状态管理**：简单用 React Context / 复杂用 Zustand / Jotai？
> - **文件上传**：需要吗？
>   - 如需要 → Uploadthing / Cloudinary / AWS S3？
> - **支付功能**：需要吗？
>   - 如需要 → Stripe / Paddle / PayPal？
> - **邮件服务**：需要发邮件吗？
>   - 如需要 → Resend / SendGrid / Mailgun？
> - **部署环境**：Vercel（推荐）/ Netlify / 自托管服务器？
>
> **我的回答：**
> ````
> - 数据库：[选择]
> - 认证方案：[ ] 不需要  [ ] 需要 → 使用 [___]
> - 状态管理：[选择]
> - 文件上传：[ ] 不需要  [ ] 需要 → 使用 [___]
> - 支付功能：[ ] 不需要  [ ] 需要 → 使用 [___]
> - 邮件服务：[ ] 不需要  [ ] 需要 → 使用 [___]
> - 部署环境：[选择]
> ````
>
> ---
>
> ### 6. 功能性约束
> **请问我：**
> - 是否需要 SEO 优化？（影响 SSR/SSG 策略）
> - 是否需要实时功能？（如：聊天、通知、协作编辑）
>   - 如需要 → WebSocket / Server-Sent Events / Polling？
> - 是否需要多语言支持（国际化）？
> - 性能要求？
>   - 首屏加载时间目标：< 2s / < 3s / < 5s
>   - 预计并发用户数：< 100 / 100-1000 / 1000+
>
> **我的回答：**
> ````
> - SEO 优化：[ ] 不需要  [ ] 需要（哪些页面需要：___）
> - 实时功能：[ ] 不需要  [ ] 需要（具体场景：___）
> - 多语言：[ ] 不需要  [ ] 需要（支持语言：___）
> - 性能要求：
>   - 首屏加载：< ___ 秒
>   - 并发用户：约 ___ 人
> ````
>
> ---
>
> ### 7. 非功能性需求
> **请问我：**
> - **权限设计**：谁能看什么？谁能做什么？
>   - 示例：Admin（全部权限）、Editor（增改查）、Viewer（只读）
> - **错误处理**：用户做错操作时如何提示？
>   - Toast 消息 / Modal 弹窗 / 内联错误提示
> - **数据验证**：表单验证规则？
>   - 示例：邮箱格式、密码强度（最少8位+数字+字母）、手机号格式
> - **安全要求**：
>   - [ ] HTTPS 强制
>   - [ ] CSRF 防护
>   - [ ] Rate Limiting（API 频率限制）
>   - [ ] 敏感数据加密（密码、支付信息）
>
> **我的回答：**
> ````
> 权限设计：
> - 角色1（如 Admin）：可以 ___
> - 角色2（如 User）：可以 ___
> 
> 错误提示方式：[Toast / Modal / 内联]
> 
> 表单验证规则：
> - 邮箱：___
> - 密码：___
> - 其他：___
> 
> 安全要求：
> - [ ] HTTPS
> - [ ] CSRF 防护
> - [ ] Rate Limiting
> - [ ] 数据加密
> ````
>
> ---
>
> ## 🛡️ 第二步：项目可持续性评估
>
> ### ✅ 扩展性声明（方便后期新功能开发）
> **请问我：**
> - [ ] 未来是否可能添加移动端 App？（需要预留 API）
> - [ ] 是否需要第三方集成能力？（如：Webhook、OAuth）
> - [ ] 是否需要插件化架构？（支持第三方扩展）
> - [ ] 数据迁移策略？（开发环境 vs 生产环境的数据库迁移方案）
>
> **我的回答：**
> ````
> - 移动端 App：[ ] 不需要  [ ] 未来可能需要
> - 第三方集成：[ ] 不需要  [ ] 需要（类型：___）
> - 插件化：[ ] 不需要  [ ] 需要
> - 数据迁移：[ ] 使用 Prisma Migrate  [ ] 其他方案
> ````
>
> ---
>
> ### ✅ 代码规范性规则（确保代码结构一致性）
> **默认采用以下规范（如有特殊要求请说明）：**
> - [x] 文件夹结构：`/app`（路由）、`/components`（组件）、`/lib`（工具）、`/prisma`（数据库）
> - [x] 命名规范：
>   - 组件用 PascalCase（如 `UserCard.tsx`）
>   - 函数用 camelCase（如 `getUserById`）
>   - 常量用 UPPER_CASE（如 `MAX_FILE_SIZE`）
> - [x] TypeScript 严格模式：禁止使用 `any`，所有函数必须有返回类型
> - [x] 组件拆分原则：每个组件不超过 200 行，职责单一
> - [x] 注释规范：复杂逻辑必须注释，公共函数必须有 JSDoc
>
> **特殊要求：**
> ````
> [如有特殊的代码规范要求，请在此说明]
> ````
>
> ---
>
> ### ✅ 安全保护机制（根据项目需求勾选）
> - [ ] **输入验证**：使用 Zod 验证所有用户输入（客户端 + 服务端双重验证）
> - [ ] **SQL 注入防护**：仅使用 Prisma ORM，禁止原始 SQL 查询
> - [ ] **XSS 防护**：避免使用 `dangerouslySetInnerHTML`，使用 DOMPurify 清理 HTML
> - [ ] **CSRF 防护**：Next.js Server Actions 自动处理
> - [ ] **Rate Limiting**：API 路由添加频率限制（如：每分钟 60 次请求）
> - [ ] **密码安全**：使用 bcrypt 加密，最少 8 位 + 数字 + 字母
> - [ ] **环境变量保护**：`.env.local` 不上传到 Git，使用 `.env.example` 模板
> - [ ] **JWT Token 管理**：设置合理过期时间，使用 HttpOnly Cookie
>
> **我的选择：**
> ````
> 以上安全机制中，我特别需要：[列出优先级最高的 3-5 项]
> ````
>
> ---
>
> ## 📤 第三步：最终输出格式
>
> 当我收集完以上信息后，请输出一份**完整的 Vibe Code 提示词**，必须包含以下内容：
>
> ---
>
> ## 1. 项目概述
> ````
> 一句话描述项目是什么、解决什么问题
> ````
>
> ---
>
> ## 2. 核心功能清单（按优先级排序）
> ````markdown
> ### P0（必须有 - MVP）
> - [ ] 功能1
> - [ ] 功能2
> 
> ### P1（重要但非必需）
> - [ ] 功能3
> 
> ### P2（优化项）
> - [ ] 功能4
> ````
>
> ---
>
> ## 3. 完整 Prisma Schema
> ````prisma
> // prisma/schema.prisma
> 
> generator client {
>   provider = "prisma-client-js"
> }
> 
> datasource db {
>   provider = "postgresql" // 根据实际选择
>   url      = env("DATABASE_URL")
> }
> 
> model User {
>   id        String   @id @default(cuid())
>   email     String   @unique
>   name      String?
>   createdAt DateTime @default(now())
>   updatedAt DateTime @updatedAt
>   
>   // 关系
>   posts     Post[]
> }
> 
> model Post {
>   id        String   @id @default(cuid())
>   title     String
>   content   String
>   published Boolean  @default(false)
>   authorId  String
>   
>   author    User     @relation(fields: [authorId], references: [id])
>   
>   createdAt DateTime @default(now())
>   updatedAt DateTime @updatedAt
>   
>   @@index([authorId])
> }
> ````
>
> ---
>
> ## 4. 页面路由结构树
> ````
> /app
> ├── (auth)                    # 认证相关路由组
> │   ├── login/
> │   │   └── page.tsx         # 登录页
> │   └── register/
> │       └── page.tsx         # 注册页
> ├── (dashboard)              # 仪表盘路由组
> │   ├── layout.tsx           # 仪表盘布局
> │   ├── page.tsx             # 首页
> │   ├── posts/
> │   │   ├── page.tsx         # 文章列表
> │   │   ├── [id]/
> │   │   │   └── page.tsx     # 文章详情
> │   │   └── new/
> │   │       └── page.tsx     # 创建文章
> │   └── settings/
> │       └── page.tsx         # 设置页
> └── api/
>     ├── auth/
>     │   └── [...nextauth]/
>     │       └── route.ts     # NextAuth 配置
>     ├── posts/
>     │   ├── route.ts         # GET /api/posts, POST /api/posts
>     │   └── [id]/
>     │       └── route.ts     # GET/PATCH/DELETE /api/posts/[id]
>     └── users/
>         └── route.ts         # 用户相关 API
> ````
>
> ---
>
> ## 5. 核心组件说明（带 Props 接口）
> ````typescript
> // components/PostCard.tsx
> interface PostCardProps {
>   post: {
>     id: string;
>     title: string;
>     content: string;
>     createdAt: Date;
>     author: {
>       name: string;
>       email: string;
>     };
>   };
>   onEdit?: (id: string) => void;
>   onDelete?: (id: string) => void;
> }
> 
> export function PostCard({ post, onEdit, onDelete }: PostCardProps) {
>   // 实现...
> }
> ````
> ````typescript
> // components/UserAvatar.tsx
> interface UserAvatarProps {
>   user: {
>     name: string;
>     email: string;
>     image?: string | null;
>   };
>   size?: 'sm' | 'md' | 'lg';
>   className?: string;
> }
> 
> export function UserAvatar({ user, size = 'md', className }: UserAvatarProps) {
>   // 实现...
> }
> ````
>
> ---
>
> ## 6. API 端点设计（RESTful 规范）
> ````markdown
> ### 认证相关
> - POST   /api/auth/login          # 登录
> - POST   /api/auth/register       # 注册
> - POST   /api/auth/logout         # 登出
> 
> ### 文章管理
> - GET    /api/posts               # 获取文章列表（支持分页、筛选）
> - POST   /api/posts               # 创建文章
> - GET    /api/posts/[id]          # 获取文章详情
> - PATCH  /api/posts/[id]          # 更新文章
> - DELETE /api/posts/[id]          # 删除文章
> 
> ### 用户管理
> - GET    /api/users               # 获取用户列表（Admin only）
> - GET    /api/users/me            # 获取当前用户信息
> - PATCH  /api/users/me            # 更新当前用户信息
> ````
>
> ---
>
> ## 7. 状态管理策略
> ````markdown
> ### 全局状态（使用 Zustand）
> - 用户认证状态（currentUser, isAuthenticated）
> - 主题设置（theme: 'light' | 'dark'）
> - 通知/Toast 消息
> 
> ### 服务端状态（使用 React Query / SWR）
> - 文章列表数据
> - 用户信息数据
> - 实现自动缓存、重新验证、乐观更新
> 
> ### 表单状态（使用 React Hook Form）
> - 登录表单
> - 注册表单
> - 文章编辑表单
> ````
>
> ---
>
> ## 8. 错误处理方案
> ````markdown
> ### 表单验证
> - 库：Zod + React Hook Form
> - 示例：
> ```typescript
>   const loginSchema = z.object({
>     email: z.string().email("请输入有效的邮箱地址"),
>     password: z.string().min(8, "密码至少8位"),
>   });
> ```
> 
> ### API 错误
> - 统一错误响应格式：
> ```json
>   {
>     "error": {
>       "code": "UNAUTHORIZED",
>       "message": "用户未登录",
>       "details": {}
>     }
>   }
> ```
> - 错误提示：使用 Toast 组件（如 sonner）
> 
> ### 边界错误
> - 使用 Error Boundary 捕获组件错误
> - 提供友好的错误页面（404, 500）
> ````
>
> ---
>
> ## 9. 样式系统约定
> ````markdown
> ### Tailwind 自定义配置
> ```javascript
> // tailwind.config.ts
> export default {
>   theme: {
>     extend: {
>       colors: {
>         primary: {
>           50: '#...',
>           500: '#...',  // 主色
>           900: '#...',
>         },
>       },
>     },
>   },
> }
> ```
> 
> ### 组件库
> - 使用 shadcn/ui（可选但推荐）
> - 自定义组件放在 `/components/ui`
> 
> ### 响应式断点
> - sm: 640px   # 手机横屏
> - md: 768px   # 平板
> - lg: 1024px  # 笔记本
> - xl: 1280px  # 桌面
> ````
>
> ---
>
> ## 10. 部署检查清单
> ````markdown
> ### 环境变量配置（.env.example）
> - [ ] DATABASE_URL
> - [ ] NEXTAUTH_SECRET
> - [ ] NEXTAUTH_URL
> - [ ] [其他第三方服务 API Key]
> 
> ### 数据库迁移
> - [ ] 运行 `npx prisma migrate deploy`
> - [ ] 运行 `npx prisma generate`
> 
> ### 生产环境测试
> - [ ] 所有 API 端点测试通过
> - [ ] 表单验证正常工作
> - [ ] 认证流程完整
> - [ ] 错误处理符合预期
> 
> ### 性能优化
> - [ ] 图片使用 Next.js Image 组件
> - [ ] 启用 gzip 压缩
> - [ ] 配置 CDN（如果需要）
> - [ ] 数据库查询优化（添加索引）
> 
> ### 安全检查
> - [ ] 环境变量未泄露
> - [ ] HTTPS 已启用
> - [ ] CORS 配置正确
> - [ ] Rate Limiting 已配置
> ````
>
> ---
>
> ## ⚠️ 常见错误提醒（请在需求阶段避免）
>
> | ❌ 错误示范             | ✅ 正确示范                                                   |
> | ---------------------- | ------------------------------------------------------------ |
> | "做一个用户友好的界面" | "参考 Linear 的侧边栏导航 + 卡片布局，使用浅色主题"          |
> | "用户表、文章表"       | "User 表：id, email(唯一), name, avatar, role, createdAt<br>Post 表：id, title, content, authorId(外键), published, createdAt" |
> | "需要权限管理"         | "3个角色：Admin(增删改查所有), Editor(增改查自己的), Viewer(只读)" |
> | "尽可能快"             | "首屏加载 < 2s，列表支持虚拟滚动（超过100条数据），使用 SSG 预渲染静态页面" |
> | "安全一点"             | "使用 bcrypt 加密密码、JWT token 7天过期、API 限制每分钟60次请求" |
>
> ---
>
> ## 🎯 开始填写
>
> 请按照以上结构，逐步填写你的项目信息。填写完成后，我将基于你的回答生成一份**可直接使用的完整 Vibe Code 提示词**！
>
> **现在就开始第一个问题：**
> 1. **你的项目叫什么名字？**
> 2. **一句话描述它解决什么问题？**
>
> ---
>
> ## 📝 使用说明
>
> 1. **复制这个模板**到新的对话窗口
> 2. **逐步填写**每个「我的回答」部分（不需要一次性填完，可以分多次）
> 3. **提交后** AI 会基于你的回答生成完整的技术方案
> 4. **迭代优化**：如果有遗漏或需要调整，随时补充说明
>
> **提示**：如果某个问题暂时不确定，可以先写「待定」或「跳过」，后续再补充！🚀


2. 使用“提示词生成器”框架：

   - 目前市面上有非常成熟的提示词框架（如 **CO-STAR** 或 **BRTR**），你可以直接套用：
     | 模块           | 用大白话描述项目需求              |
     | -------------- | --------------------------------- |
     | Role (角色)    | 帮我写代码的专家                  |
     | Task (任务)    | Windows Server 备份，两个 IP 轮换 |
     | Context (背景) | 我要在凌晨执行，怕网络断开        |
     | Style (风格)   | 代码要稳，要有报错提示            |
     | Format (格式)  | 一个 `.py` 文件，加上简单的注释   |

     **操作方式**： 把上面这个表格的内容丢给 AI，说：“按这个要求给我写个详细的 Prompt”。
     
     

3. Vibe Coding 的精髓：迭代而非一次性完成

   - 小白最常见的误区是觉得提示词必须“一步到位”。实际上，Vibe Coding 的流程更像是**“聊天”**：
   - **第一轮（粗糙意图）：** “给我写个 Python 备份脚本，检查 IP。”（AI 生成了一个简单的代码）
   - **第二轮（纠偏）：** “不行，你没考虑 Windows Server 2022，而且我要用 robocopy。”（AI 改进了代码）
   - **第三轮（细化）：** “加上哈希校验，如果失败了发个通知。”（AI 最终完善）

   
   
   **这种通过“对话 -> 纠偏 -> 增加细节”的过程，其实就是在变相地编写一个长篇提示词，只不过它是碎片化的、符合人类直觉的。**



---

|建议次序|步骤名称|理由|
|---|---|---|
|第一步|核心前端原型 (Mock)|继续保持你的习惯。先画出最核心的页面，但不要写太复杂，只是为了定调子。|
|第二步|	数据库建模 (AI 核心)|	关键点！ 告诉 AI：“基于刚才的页面，帮我设计数据库表”。有了表结构，AI 后面写代码就有了准则。|
|第三步|	登录 + 基础 API|	趁着还没写太多业务逻辑，把身份验证搞定。|
|第四步|	模块功能全速开发|	这时候 AI 已经知道数据库长啥样、谁有权限看，它写出的代码准确率会提高 80%。|
|第五步|	部署上线|	最后的冲刺。|



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



> [!TIP] 
>
> - **项目需求描述**
>
> ````markdown
> # Role: Senior Full-stack Architect & Vibe Coding Specialist
> 
> # Task: Initialize "My Treasure Box" - A Personal Collection Web App
> 
> We are starting a new project called "My Treasure Box" (个人收集品网页). This is a modern, high-end gallery-style application for showcasing personal collectibles.
> 
> ## 1. Core Tech Stack (The Vibe Stack)
> Please initialize the project using the following technologies:
> - Framework: Next.js (App Router, TypeScript)
> - Styling: Tailwind CSS
> - UI Components: Shadcn/UI (Modern, minimalist aesthetic)
> - Icons: Lucide React
> - Database & Auth: Supabase (PostgreSQL + Auth)
> - ORM: Prisma
> - State Management: React Server Components + Server Actions
> 
> ## 2. Project Structure & Organization
> Please set up a clean, modular directory structure:
> - `/app`: App router (pages, layouts)
> - `/components`: (UI, business-specific, and shared components)
> - `/lib`: (Prisma client, Supabase config, utility functions)
> - `/actions`: (Server Actions for backend logic/APIs)
> - `/types`: (TypeScript interfaces/definitions)
> - `/hooks`: (Custom React hooks)
> 
> ## 3. Immediate Initialization Tasks
> 1. Setup a basic Next.js project with Tailwind and TypeScript.
> 2. Install and initialize Shadcn/UI with a "Zinc" or "Slate" theme.
> 3. Configure the `layout.tsx` with a responsive <Navbar /> (including Login/Register buttons and a Logo placeholder).
> 4. Set up the Prisma schema file with a `User` model and a `CollectionItem` model (including: title, description, imageUrl, category, createdAt).
> 5. Create a `.env.example` file including placeholders for SUPABASE_URL, SUPABASE_ANON_KEY, and DATABASE_URL.
> 6. Design a professional, dark-mode-first Landing Page hero section to set the "Vibe".
> 7. Run ```npm install -D prettier prettier-plugin-tailwindcss eslint-plugin-simple-import-sort eslint-config-prettier``` to install development dependencies.
> 8. Create a `.prettierrc` file with the following content:
> ```json
> {
>   "semi": false,
>   "singleQuote": true,
>   "trailingComma": "all",
>   "printWidth": 100,
>   "tabWidth": 2,
>   "plugins": ["prettier-plugin-tailwindcss"],
>   "tailwindConfig": "./tailwind.config.ts"
> }
> ```
> 
> 9. Create a `.eslintrc.json` file with the following content:
> ```json
> {
>   "extends": [
>     "next/core-web-vitals",
>     "eslint:recommended",
>     "plugin:@typescript-eslint/recommended",
>     "prettier"
>   ],
>   "plugins": ["simple-import-sort"],
>   "rules": {
>     "simple-import-sort/imports": "error",
>     "simple-import-sort/exports": "error",
>     "@typescript-eslint/no-unused-vars": ["warn", { "argsIgnorePattern": "^_" }],
>     "no-console": ["warn", { "allow": ["warn", "error"] }]
>   },
>   "overrides": [
>     {
>       "files": ["*.ts", "*.tsx", "*.js"],
>       "rules": {
>         "simple-import-sort/imports": [
>           "error",
>           {
>             "groups": [
>               ["^react", "^next", "^@", "^[a-z]"], // 外部库和内置库
>               ["^@/components", "^@/lib", "^@/hooks"], // 内部别名路径
>               ["^\\.\\.(?!/?$)", "^\\.\\./?$", "^\\./(?=.*/)(?!/?$)", "^\\.(?!/?$)", "^\\./?$"], // 相对路径
>               ["^.+\\.s?css$"] // 样式文件
>             ]
>           }
>         ]
>       }
>     }
>   ]
> }
> ```
> 
> 10. Adding code to `tsconfig.json` absolute imports:
> ```json
> {
>   "compilerOptions": {
>     "baseUrl": ".",
>     "paths": {
>       "@/*": ["./*"]
>     }
>   }
> }
> ```
> 
> ## 4. UI/UX Vibe Requirements
> - Theme: Minimalist, "Apple-esque" gallery style.
> - Use subtle animations (Framer Motion if available, or Tailwind transitions).
> - Typography: Use Inter or a clean Sans-serif font.
> - Grid: A clean, responsive masonry or card grid for future items.
> 
> Please proceed with the file generation and project scaffolding. Let's make it look premium from the first commit!
> 
> ````

> [!TIP]
>
> - **数据结构设计**
>
> ```mark
> # Role: Senior Database Architect & Full-stack Engineer
> # Context: 
> I am building a "Personal Collection Gallery" using Next.js, Supabase (PostgreSQL), and Prisma ORM. 
> The app allows users to register, log in, and manage their physical or digital collectibles (e.g., watches, trading cards, sneakers, or digital art).
> 
> # Task:
> Design a robust, scalable database schema and implement the connection logic.
> 
> # Requirements:
> 1. **User Entity**: Handle authentication (mapped to Supabase Auth). Include `email`, `display_name`, `avatar_url`, and `bio`.
> 2. **CollectionItem Entity**: 
>    - Each item must belong to a `User`.
>    - Fields: `id`, `title`, `description` (markdown supported), `acquisition_date`, `valuation` (optional), `is_public` (boolean).
>    - Media: Support multiple image URLs in an array or a related table.
> 3. **Categorization**: 
>    - A `Category` table (e.g., "Vintage", "Limited Edition").
>    - A many-to-many relationship for `Tags`.
> 4. **Audit Fields**: Every table must have `created_at` and `updated_at` timestamps.
> 5. **Type Safety**: Generate TypeScript types based on the schema.
> 
> # Deliverables:
> 1. A complete `schema.prisma` file (or SQL migration script for Supabase).
> 2. A database client utility file (e.g., `lib/prisma.ts` or `lib/supabase.ts`) that ensures a singleton connection instance.
> 3. A brief explanation of the relationships (One-to-Many, Many-to-Many) used.
> 
> # Vibe/Style:
> - Use camelCase for Prisma fields and snake_case for PostgreSQL underlying columns if necessary.
> - Ensure referential integrity (e.g., ON DELETE CASCADE for items when a user is deleted).
> 
> ```



> [!TIP]
>
> - **后端架构设计**
>
> ```markdown
> # Role: Senior Full-Stack Architect
> # Task: Implementation of Backend Logic, Server Actions, and Storage for "Personal Collectibles Gallery"
> 
> ## Context
> I am building a personal collectibles website. We are using **Next.js (App Router)**, **Supabase** (Database & Auth), and **Prisma** (or Supabase Client) for ORM. The goal is to establish a secure, type-safe backend flow for managing personal collections.
> 
> ## Requirements
> 
> ### 1. Server Actions (The Logic)
> Instead of traditional API routes, implement **Next.js Server Actions** located in `@/app/actions/`. I need actions for:
> - `getCollections`: Fetch all items for the current user (with optional public view logic).
> - `addCollectionItem`: Validate input using **Zod**, handle image uploads, and insert data.
> - `updateCollectionItem`: Edit details of an existing item.
> - `deleteCollectionItem`: Remove item from DB and delete its corresponding image from storage.
> 
> ### 2. File Storage Integration (Supabase Storage)
> - Implement a utility to upload images to a Supabase bucket named `collectibles`.
> - Logic should include: generating unique filenames, setting proper content types, and returning the `publicUrl`.
> 
> ### 3. Authentication & Middleware (The Gatekeeper)
> - Ensure all "write" actions (Add, Edit, Delete) are protected. 
> - Verify the user's session using `supabase.auth.getUser()`.
> - Implement a middleware check to redirect unauthenticated users away from the `/dashboard` or `/admin` routes.
> 
> ### 4. Data Validation & Type Safety
> - Use **Zod** to define a schema for a "Collectible Item":
>   - `title`: String, min 2 chars.
>   - `description`: String, optional.
>   - `tags`: Array of strings.
>   - `imageUrl`: String (URL).
>   - `isPublic`: Boolean.
> 
> ### 5. Error Handling & Feedback
> - Wrap actions in try-catch blocks.
> - Return a standardized response object: `{ success: boolean, data?: any, error?: string }`.
> 
> ## Instructions for AI
> 1. Start by setting up the **Supabase client** (Server-side version).
> 2. Create the **Zod schema** for validation.
> 3. Write the **Server Actions** mentioned above.
> 4. Provide a code snippet for a **React Hook** or a basic **Client Component** showing how to trigger the `addCollectionItem` action with a file upload.
> 5. Ensure all code follows clean architecture principles and is fully TypeScript typed.
> 
> "Let's build a robust, scalable backend 'brain' that is easy to maintain."
> 
> ```





> [!TIP]
>
> - **前端网页设计**
>
> ```mark
> # Role: Senior Creative Developer & UI/UX Specialist
> ## Context: 
> We have the functional core of my Personal Collection Web App. Now, I want to inject a "High-End Gallery Vibe" into the interface. The goal is a "Premium Minimalist" aesthetic that makes my collectibles feel like curated museum pieces.
> 
> ### 1. Visual Identity & Design System
> - **Theme:** Implement a sophisticated "Sophisticated Dark Mode" as the default. 
> - **Color Palette:** - Background: Deep Charcoal (#0B0B0B).
>   - Cards: Slightly lifted Zinc (#18181B) with a 1px subtle border (#27272A).
>   - Accents: Soft Gold (#D4AF37) or Electric Blue (#3B82F6) for interactive elements only.
> - **Typography:** - Headings: Serif font (e.g., Playfair Display or Inter Tight) for a luxury feel.
>   - Body: Clean Sans-serif (e.g., Inter or Geist Sans) for readability.
> 
> ### 2. Layout & Components (Tailwind + Shadcn/UI)
> - **The Navigation:** A floating, glassmorphic (backdrop-blur) navbar. Use a minimal profile avatar for the login/auth section.
> - **The Hero Section:** Create a bold, centered "Collection Statement" with a subtle mesh gradient background.
> - **The Grid:** Use a **Responsive Masonry Layout** for the collection items. 
> - **Collection Cards:** - No harsh shadows; use subtle inner borders.
>   - Implement a "Glassmorphism" effect on the text overlay.
>   - Ensure images have a consistent aspect ratio (e.g., 4:5) with `object-cover`.
> - **Empty States:** Design a beautiful "No items found" state using a Lucide icon and a muted call-to-action button.
> 
> ### 3. Motion & Micro-interactions (Framer Motion)
> - **Page Transitions:** Add a "Fade & Slide Up" entrance for the entire grid when the page loads.
> - **Hover States:** - When hovering a collection card: Subtle scale up (1.02), increase border brightness, and reveal hidden metadata (e.g., "Date Acquired").
>   - Use a "Magnetic" effect for the primary "Add New Item" button.
> - **Loading Vibe:** Replace standard spinners with **Shadcn Skeleton** loaders that pulse gently to match the grid layout.
> 
> ### 4. Detail View (The "Gallery" Experience)
> - When a user clicks a collection item, open a **Sheet** or **Dialog** (Shadcn).
> - **Layout:** Large image on the left/top, elegant metadata list on the right/bottom.
> - **Interaction:** Add a "Share" button and a "Download High-Res" action.
> 
> ### Implementation Instructions:
> 1. Use **Tailwind CSS** for all styling.
> 2. Use **Framer Motion** for all animations.
> 3. Ensure the design is **mobile-first** and fully responsive.
> 4. Refactor existing components to use these styles without breaking the current database logic.
> 
> "Let’s make this look like a premium digital vault. Please start by updating the Global CSS and the Main Layout first."
> 
> ```
>
> 



### 知识库

- GTD 是什么？
- TBD 是什么？
- 
