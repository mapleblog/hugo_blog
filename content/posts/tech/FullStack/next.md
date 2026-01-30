+++
title = 'Next'
date = 2026-01-29T15:54:53+08:00
draft = true
slug = "d0b3f94"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"
+++

# Next
是目前全栈开发的行业标准，也是 AI 最擅长处理的框架。
- **前端+后端**： Next.js (React)
- **样式**： Tailwind CSS (写起来飞快)
- **数据库工具**： Prisma (让 AI 帮你管理数据库的神器)
- **本地数据库**： SQLite (不需要安装任何软件，就是一个文件)

#### 第一步：初始化“地基”
请打开你的终端（Terminal），依次运行以下命令。这是任何全栈项目的标准起手式：
1. 创建项目：
	```bash
	npx create-next-app@latest my-vibe-project
	```
	提示：一路选 Yes/默认即可，记得选上 TypeScript 和 Tailwind CSS）
	
2. 进入文件夹：
	```bash
	cd my-vibe-project
	```

3. 安装数据库工具：
	```bash
	npm install prisma --save-dev
	npx prisma init --datasource-provider sqlite
	```
	
#### Supabase 配置操作：

> [!IMPORTANT]
> 
> **DATABASE_URL** =
> **DIRECT_URL** =
> **NEXT_PUBLIC_SUPABASE_URL** =
> **NEXT_PUBLIC_SUPABASE_ANON_KEY** =
> **SUPABASE_SERVICE_ROLE_KEY** =
> **NEXT_PUBLIC_APP_URL** =
> **NODE_ENV** =
> 
> 

:notebook: 请按照以下步骤验证并修复您的数据库连接信息：

1. 登录 Supabase 控制台 :
   - 进入 Settings -> Database -> Connection parameters 。
2. 验证密码 :
   - 确认您在 .env 中填写的密码是否为您在 Supabase 项目中设置的数据库密码（注意：这 不是 您的 Supabase 账号登录密码，而是数据库用户的密码）。
   - 如果您忘记了数据库密码，可以在 Supabase 控制台的 Database -> Roles 中重置 postgres 用户的密码。
3. 获取正确的连接字符串 :
   - 在 Supabase 控制台点击 Connect 按钮。
   - 选择 ORMs -> Prisma 。
   - Direct URL (用于 DIRECT_URL ): 确保取消勾选 "Use connection pooling"（如果可用），通常端口为 5432 。
   - Transaction Pooler (用于 DATABASE_URL ): 确保勾选 "Use connection pooling"，模式为 Transaction，端口通常为 6543 。

当 Prisma 返回 P1000 错误代码时，它的核心含义是：“数据库服务器拒绝了你的身份验证尝试”。

简单来说，就是你的 DATABASE_URL 或 DIRECT_URL 里的“账号”或“密码”写错了，或者数据库还没准备好。对于 Supabase 用户，这通常由以下几个原因引起：

1. 最常见原因：密码包含特殊字符这是 90% 的开发者报错的原因。如果你的 Supabase 数据库密码包含 @、#、$、! 等符号，Prisma 会解析出错。

   - 错误现象：Prisma 把密码里的 @ 当成了分隔符，导致它去找错误的服务器地址。

   - 解决方法：必须对密码进行 URL 编码 (URL Encoding)。

   - `@ --> %40`

   - `# --> %23`

   - `$ --> %24`

   - `: --> %3A`

**示例**：如果密码是 `Zen#Task@2026`：
❌ **错误**：`...:Zen#Task@2026@aws-0...`
✅ **正确**：`...:Zen%23Task%402026@aws-0...`

2. 密码输入错误（或忘记密码）

   P1000 最直观的原因就是密码确实不对。注意：**数据库密码**是你创建项目时手动设置的那个，**不是**你的 Supabase 登录密码。

   - 解决方法: 如果你不确定密码，去 Supabase 后台重置
     1. 进入 **Project Settings**  -->  **Database**
     2. 找到 **Database Password** 区域
     3. 点击 **Reset Database Password**
     4. **注意**：重置后记得更新 `.env` 里的 **URL**

3. 项目 ID 或 主机地址 (Host) 错误

   请检查你的 URL 格式是否完全符合 Supabase 提供的模板。

   - **标准格式回顾**： `postgresql://postgres.[项目ID]:[编码后的密码]@[服务器区域].pooler.supabase.com:[端口]/postgres`
   - **检查点**：
     - 用户名是否为 `postgres`（通常是固定的）
     - 项目 ID（postgres.**[这里]**) 是否正确
     - 是否遗漏了端口号（`6543` 或 `5432`）
