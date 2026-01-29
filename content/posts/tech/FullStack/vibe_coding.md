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

# Vibe Coding

|建议次序|步骤名称|理由|
|---|---|---|
|第一步|核心前端原型 (Mock)|继续保持你的习惯。先画出最核心的页面，但不要写太复杂，只是为了定调子。|
|第二步|	数据库建模 (AI 核心)|	关键点！ 告诉 AI：“基于刚才的页面，帮我设计数据库表”。有了表结构，AI 后面写代码就有了准则。|
|第三步|	登录 + 基础 API|	趁着还没写太多业务逻辑，把身份验证搞定。|
|第四步|	模块功能全速开发|	这时候 AI 已经知道数据库长啥样、谁有权限看，它写出的代码准确率会提高 80%。|
|第五步|	部署上线|	最后的冲刺。|

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
> ```
>
> 
