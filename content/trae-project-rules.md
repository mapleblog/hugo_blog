# Trae 项目规则模板

> 技术栈：Next.js · Prisma · Tailwind CSS

---

## 一、项目概览

```
项目名称：[YOUR_PROJECT_NAME]
版本：0.1.0
描述：[项目简短描述]
```

---

## 二、技术栈规范

### 核心依赖

| 层级 | 技术 | 版本要求 |
|------|------|----------|
| 框架 | Next.js (App Router) | ^14.x |
| ORM | Prisma | ^5.x |
| 样式 | Tailwind CSS | ^3.x |
| 语言 | TypeScript | ^5.x |
| 运行时 | Node.js | >=18.x |

### 禁止替换

- **不得**将 Next.js 替换为 Vite、Remix 或其他框架
- **不得**将 Prisma 替换为 Drizzle、TypeORM 或原生 SQL
- **不得**将 Tailwind 替换为 CSS Modules、styled-components 或其他 CSS 方案

---

## 三、目录结构

```
.
├── app/                        # Next.js App Router
│   ├── (auth)/                 # 路由分组：认证相关页面
│   ├── (dashboard)/            # 路由分组：主应用页面
│   ├── api/                    # API Route Handlers
│   │   └── [...]/route.ts
│   ├── globals.css             # 全局样式（仅 Tailwind 指令）
│   ├── layout.tsx              # 根 Layout
│   └── page.tsx                # 首页
├── components/
│   ├── ui/                     # 基础 UI 组件（无业务逻辑）
│   └── [feature]/              # 按功能模块划分的业务组件
├── lib/
│   ├── db.ts                   # Prisma Client 单例
│   ├── auth.ts                 # 认证工具函数
│   └── utils.ts                # 通用工具函数
├── prisma/
│   ├── schema.prisma           # 数据库 Schema
│   ├── seed.ts                 # 数据填充脚本
│   └── migrations/             # 迁移文件（勿手动修改）
├── types/
│   └── index.ts                # 全局类型定义
├── hooks/                      # 自定义 React Hooks
├── public/                     # 静态资源
├── .env.local                  # 本地环境变量（不提交）
├── .env.example                # 环境变量模板（必须提交）
├── next.config.ts
├── tailwind.config.ts
├── tsconfig.json
└── package.json
```

---

## 四、编码规范

### 4.1 通用规则

- 所有文件使用 **TypeScript**，禁止使用 `any`，用 `unknown` 替代
- 组件文件使用 **PascalCase**（`UserCard.tsx`）
- 工具函数、hooks 使用 **camelCase**（`useUserData.ts`）
- 常量使用 **UPPER_SNAKE_CASE**
- 每个文件只导出一个主要内容（default export）

### 4.2 Next.js 规范

```typescript
// ✅ Server Component（默认，无需声明）
export default async function Page() {
  const data = await fetchData()
  return <div>{data}</div>
}

// ✅ Client Component（需要交互时才使用）
'use client'
import { useState } from 'react'
export default function Counter() { ... }

// ✅ API Route Handler
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server'
export async function GET(req: NextRequest) {
  return NextResponse.json({ ... })
}
```

**原则：**
- 优先使用 **Server Components**，仅在必要时使用 `'use client'`
- 数据获取在 Server Component 中直接 `async/await`，不使用 `useEffect` 拉取数据
- 使用 `next/image` 替代原生 `<img>`，使用 `next/link` 替代原生 `<a>`
- 敏感操作（写数据库）使用 **Server Actions** 或 API Routes，不在客户端直接操作

### 4.3 Prisma 规范

```typescript
// lib/db.ts — Prisma Client 单例（必须使用此模式）
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as { prisma: PrismaClient }

export const db =
  globalForPrisma.prisma ?? new PrismaClient({ log: ['query'] })

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = db
```

**原则：**
- 始终从 `@/lib/db` 导入 `db`，禁止在业务文件中 `new PrismaClient()`
- Schema 字段命名使用 **camelCase**，数据库字段自动映射为 **snake_case**
- 每次修改 Schema 后必须执行 `prisma migrate dev`，禁止直接修改迁移文件
- 生产环境使用 `prisma migrate deploy`

```prisma
// prisma/schema.prisma 示例规范
model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@map("users")  // 表名使用 snake_case 复数
}
```

### 4.4 Tailwind CSS 规范

```tsx
// ✅ 正确：使用 Tailwind 工具类
<button className="rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
  提交
</button>

// ✅ 条件类名使用 clsx / cn 工具
import { cn } from '@/lib/utils'
<div className={cn('p-4', isActive && 'bg-blue-50', className)} />

// ❌ 禁止内联 style（除非动态值无法用 Tailwind 表达）
<div style={{ color: 'red' }} />
```

**原则：**
- 禁止在 `globals.css` 中写自定义 CSS，样式全部通过 Tailwind 实现
- 复用样式通过**提取组件**实现，不使用 `@apply`（除极特殊情况）
- 响应式前缀顺序：`sm:` → `md:` → `lg:` → `xl:`
- 暗色模式使用 `dark:` 前缀

---

## 五、环境变量

```bash
# .env.example（此文件提交到仓库）

# 数据库
DATABASE_URL="postgresql://user:password@localhost:5432/dbname"

# Next.js
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET=""              # openssl rand -base64 32

# 第三方服务（按需添加）
# STRIPE_SECRET_KEY=""
# RESEND_API_KEY=""
```

**规则：**
- 客户端可见变量必须以 `NEXT_PUBLIC_` 开头
- 敏感变量（API Key、Secret）**绝不**加 `NEXT_PUBLIC_` 前缀
- `.env.local` 加入 `.gitignore`，`.env.example` 必须同步更新

---

## 六、Git 规范

### 分支策略

```
main          # 生产环境，受保护，只接受 PR 合并
dev           # 开发主分支
feat/[name]   # 新功能
fix/[name]    # Bug 修复
chore/[name]  # 配置、依赖等非功能性改动
```

### Commit 格式（Conventional Commits）

```
<type>(<scope>): <subject>

type:
  feat     新功能
  fix      Bug 修复
  docs     文档
  style    格式调整（不影响逻辑）
  refactor 重构
  perf     性能优化
  test     测试
  chore    构建/工具/依赖

示例：
feat(auth): 添加 Google OAuth 登录
fix(api): 修复用户列表分页错误
chore(deps): 升级 Next.js 到 14.2
```

---

## 七、AI 协作规则（Trae 专用）

### 7.1 代码生成约束

当使用 AI 生成代码时，必须遵守以下约束：

```
技术栈约束（硬性要求）：
- 框架：仅使用 Next.js App Router，不生成 Pages Router 代码
- 数据库：仅使用 Prisma，不生成原始 SQL 或其他 ORM 代码
- 样式：仅使用 Tailwind CSS 工具类，不生成 CSS-in-JS 或 CSS Module
- 语言：所有代码使用 TypeScript，类型必须显式声明
```

### 7.2 文件修改规则

- **新增文件**：必须符合第三节目录结构规范
- **修改现有文件**：不得改变文件的核心职责
- **禁止操作**：不得修改 `prisma/migrations/` 下的任何文件

### 7.3 数据库操作规则

- 新增数据模型：只修改 `prisma/schema.prisma`，AI 不执行迁移命令
- 查询逻辑：写在 Server Component、Server Action 或 API Route 中
- 禁止在客户端组件中导入或调用 `db`

### 7.4 响应格式要求

AI 生成代码时需说明：
1. 涉及哪些文件（新增 / 修改）
2. 是否需要运行迁移（`prisma migrate dev`）
3. 是否新增环境变量（需同步更新 `.env.example`）

---

## 八、开发工作流

```bash
# 初始化项目
pnpm install
cp .env.example .env.local
# 填写 .env.local 后执行：
pnpm prisma migrate dev --name init
pnpm prisma db seed

# 日常开发
pnpm dev                         # 启动开发服务器（localhost:3000）
pnpm prisma studio               # 可视化数据库管理

# 新增数据模型后
pnpm prisma migrate dev --name [migration_name]
pnpm prisma generate             # 更新 Prisma Client 类型

# 提交前检查
pnpm lint
pnpm type-check
pnpm build                       # 确保构建通过
```

---

## 九、部署规范

| 环境 | 平台 | 分支 | 数据库迁移 |
|------|------|------|------------|
| Preview | Vercel | `dev` | 自动（`migrate deploy`） |
| Production | Vercel | `main` | 手动确认后执行 |

**部署检查清单：**
- [ ] 所有环境变量已在平台配置
- [ ] `prisma migrate deploy` 已在生产数据库执行
- [ ] `pnpm build` 本地验证通过
- [ ] PR 已通过 Code Review

---

*本规则模板适用于所有使用 Next.js + Prisma + Tailwind 技术栈的 Trae 项目。*
*如需修改技术栈或规则，须更新本文档并知会团队所有成员。*
