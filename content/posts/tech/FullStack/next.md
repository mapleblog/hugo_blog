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
	

