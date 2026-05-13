# GENERATOR_AGENT.md

> **角色**: Generator 代理（生成者）
> **职责**: 消费 Planner 输出的任务列表，严格按架构规范生成高质量代码文件，并将产物交给 Evaluator 代理审查。
> **不拆解需求，不评估质量 —— 只负责"把代码写正确"。**

---

## 1. 项目背景

| 字段 | 内容 |
|---|---|
| **项目名称** | 个人网页（Personal Website） |
| **技术栈** | Next.js 15 · TypeScript · Tailwind CSS v4 |
| **App Router** | 是（`app/` 目录，Server Components 优先） |
| **包管理器** | pnpm |
| **代码规范** | ESLint + Prettier，strict TypeScript |
| **当前阶段** | 由 Planner 的 HANDOFF 指令决定 |

---

## 2. Generator 代理的输入 / 输出契约

```
输入（来自 Planner 代理的 HANDOFF）
  └─ TASKS.md      — 待执行任务列表（含验收标准、依赖、复杂度）
  └─ PLAN.md       — 当前 Phase 上下文
  └─ ARCHITECTURE.md — 组件边界、路由结构、数据策略

输出（交给 Evaluator 代理）
  └─ 代码文件       — 严格对应 TASKS.md 中的任务 ID
  └─ TASKS.md 更新  — 将已完成任务标记为 ✅，阻塞任务标记为 🚫
  └─ LOGS.md 追加   — 记录每次生成的决策与说明
```

Generator **不修改 PLAN.md 和 ARCHITECTURE.md**，若发现规划有误须通知 Planner，不得擅自更改。

---

## 3. 生成流程（Generator 执行步骤）

```
Step 1 · 读取上下文
  ├─ 读取 AGENTS.md（定位当前阶段）
  ├─ 读取 TASKS.md（找到状态为 🔲 的任务）
  ├─ 读取 ARCHITECTURE.md（确认组件边界和文件路径）
  └─ 检查依赖任务是否已 ✅，若未完成 → 跳过，标记 🚫 并说明原因

Step 2 · 逐任务生成
  ├─ 每次只执行一个任务（单一职责）
  ├─ 在动笔前，在 TASKS.md 中将该任务标记为 ⚙️
  ├─ 生成代码，遵循第 4 节"代码生成规范"
  └─ 完成后将任务标记为 ✅（等待 Evaluator 确认）

Step 3 · 记录日志
  └─ 向 LOGS.md 追加一条记录（格式见第 6 节）

Step 4 · 移交 Evaluator
  └─ 发出 REVIEW_REQUEST（格式见第 7 节）

Step 5 · 处理评审反馈
  ├─ PASS     → 继续下一个任务
  ├─ FIX(n)   → 修复指定问题，重新提交，最多重试 2 次
  └─ ESCALATE → 超过重试次数或设计层面问题 → 通知 Planner 重新规划
```

---

## 4. 代码生成规范

### 4.1 通用规则

- **TypeScript strict 模式**：所有文件必须通过 `tsc --noEmit`，禁止使用 `any`。
- **Server Components 优先**：只有需要 `useState` / `useEffect` / 浏览器 API 的组件才加 `"use client"`。
- **文件头注释**：每个新文件第一行写明任务 ID，便于追溯。

```typescript
// [T-006] HeroSection — 首页英雄区组件
```

- **导入顺序**（Prettier 自动格式化，手写时遵循）：
  1. React / Next.js 内置
  2. 第三方库
  3. 项目内绝对路径（`@/`）
  4. 相对路径

### 4.2 Next.js 规范

```typescript
// ✅ 正确：Server Component（默认）
export default function HeroSection() { ... }

// ✅ 正确：需要交互时才声明 client
"use client"
import { useState } from "react"
export default function ContactForm() { ... }

// ✅ 正确：Metadata API（每个 page.tsx）
export const metadata: Metadata = {
  title: "...",
  description: "...",
}

// ✅ 正确：Server Action
"use server"
export async function submitContact(formData: FormData) { ... }

// ❌ 禁止：在 Server Component 中使用 useState
// ❌ 禁止：在 app/ 目录使用 getServerSideProps / getStaticProps
```

### 4.3 Tailwind CSS v4 规范

```typescript
// ✅ 正确：使用 CSS 变量 Token（在 globals.css 中定义）
<div className="bg-[--color-background] text-[--color-foreground]" />

// ✅ 正确：响应式 mobile-first
<div className="flex flex-col md:flex-row gap-4 md:gap-8" />

// ✅ 正确：语义化间距，避免魔法数字
<section className="py-16 md:py-24 px-4 md:px-8" />

// ❌ 禁止：内联 style（除非 CSS 变量动态值）
// ❌ 禁止：任意值滥用（如 w-[347px]），优先使用 Tailwind scale
```

### 4.4 组件文件结构模板

```typescript
// [T-XXX] ComponentName — 简要说明
import type { FC } from "react"
// ... 其他 imports

// ── 类型定义 ──────────────────────────────────────────
interface ComponentNameProps {
  // 明确每个 prop 的类型，不使用 PropTypes
}

// ── 子组件（若有）────────────────────────────────────
function SubComponent({ ... }: SubProps) {
  return ( ... )
}

// ── 主组件 ────────────────────────────────────────────
const ComponentName: FC<ComponentNameProps> = ({ ... }) => {
  return (
    <section aria-label="...">
      { /* 语义化 HTML，优先使用 section/article/nav/aside */ }
    </section>
  )
}

export default ComponentName
```

### 4.5 数据层规范

```typescript
// lib/data/profile.ts
// [T-004] 个人信息静态数据

export interface Profile {
  name: string
  title: string
  bio: string
  avatar: string
  skills: Skill[]
  social: SocialLink[]
}

export interface Skill {
  name: string
  level: "beginner" | "intermediate" | "advanced" | "expert"
  icon?: string
}

export interface SocialLink {
  platform: "github" | "linkedin" | "twitter" | "email" | "website"
  url: string
  label: string
}

// 静态数据导出（SSG 阶段直接 import，无需 fetch）
export const profile: Profile = {
  name: "YOUR_NAME",         // ← 占位符，待用户填写
  title: "YOUR_TITLE",
  bio: "YOUR_BIO",
  avatar: "/images/avatar.jpg",
  skills: [],
  social: [],
}
```

### 4.6 首页 — `src/app/page.tsx`

替换 create-next-app 生成的默认首页，渲染项目真实的工具导航页。
首页从 `src/config/modules.ts` 的 MODULES 注册表动态读取所有工具模块，
自动展示 active 和 coming-soon 两种状态的卡片。

执行：

​```bash
cat > src/app/page.tsx << 'EOF'
import { MODULES } from "@/config/modules";
import Link from "next/link";

export default function HomePage() {
  return (
    <main className="min-h-screen bg-muji-bg">

      {/* Header */}
      <header className="border-b border-muji-border">
        <div className="max-w-3xl mx-auto px-6 h-14 flex items-center">
          <span className="text-muji-text-primary font-normal tracking-wide">
            OfficeKit
          </span>
        </div>
      </header>

      {/* Hero */}
      <section className="max-w-3xl mx-auto px-6 py-16">
        <h1 className="text-2xl font-light text-muji-text-primary leading-snug">
          Simple tools for everyday work.
        </h1>
        <p className="mt-3 text-sm text-muji-text-secondary leading-relaxed">
          No login required. Files are processed locally and never stored.
        </p>
      </section>

      {/* Tool Grid */}
      <section className="max-w-3xl mx-auto px-6 pb-24">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {MODULES.map((mod) => (
            mod.status === "active" ? (
              <Link
                key={mod.id}
                href={mod.href}
                className="group block p-6 bg-muji-bg-card border border-muji-border
                           rounded-lg shadow-muji-sm hover:shadow-muji-md
                           transition-shadow duration-200"
              >
                <p className="text-base text-muji-text-primary font-normal">
                  {mod.label}
                </p>
                <p className="mt-1 text-sm text-muji-text-secondary leading-relaxed">
                  {mod.description}
                </p>
              </Link>
            ) : (
              <div
                key={mod.id}
                className="block p-6 bg-muji-bg border border-muji-border
                           rounded-lg opacity-50 cursor-not-allowed"
              >
                <p className="text-base text-muji-text-primary font-normal">
                  {mod.label}
                </p>
                <p className="mt-1 text-sm text-muji-text-muted leading-relaxed">
                  {mod.description}
                </p>
                <span className="mt-3 inline-block text-xs text-muji-text-muted">
                  Coming soon
                </span>
              </div>
            )
          ))}
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-muji-border">
        <div className="max-w-3xl mx-auto px-6 py-8 text-xs text-muji-text-muted">
          OfficeKit — no login, no storage, no tracking.
        </div>
      </footer>

    </main>
  );
}
EOF
​```

---

## 5. Phase 1 任务执行详单

Generator 按以下顺序逐任务执行，每个任务完成后等待 Evaluator 反馈再继续。

### T-001 · 初始化 Next.js 项目

**生成文件：**
```
package.json
tsconfig.json
next.config.ts
.eslintrc.json
.prettierrc
pnpm-lock.yaml（由 pnpm install 生成）
```

**关键配置：**
```typescript
// next.config.ts
import type { NextConfig } from "next"

const config: NextConfig = {
  experimental: {
    typedRoutes: true,        // 强类型路由
  },
  images: {
    formats: ["image/avif", "image/webp"],
  },
}
export default config
```

```json
// tsconfig.json（关键字段）
{
  "compilerOptions": {
    "strict": true,
    "baseUrl": ".",
    "paths": { "@/*": ["./*"] }
  }
}
```

**验收标准：** `pnpm dev` 启动无报错，`pnpm build` 通过。

---

### T-002 · 配置 Tailwind CSS v4

**生成文件：**
```
app/globals.css
```

**关键配置：**
```css
/* app/globals.css */
@import "tailwindcss";

@theme {
  /* ── 颜色 Token ─────────────────────────── */
  --color-background: #0a0a0a;
  --color-foreground: #ededed;
  --color-primary:    #3b82f6;   /* 待设计阶段替换 */
  --color-muted:      #6b7280;
  --color-border:     #1f2937;

  /* ── 字体 ───────────────────────────────── */
  --font-sans:  var(--font-geist-sans);
  --font-mono:  var(--font-geist-mono);

  /* ── 间距 ───────────────────────────────── */
  --spacing-section: 5rem;      /* py-20 */
  --spacing-container: 1200px;
}
```

**验收标准：** Token 变量在组件中可用，`pnpm build` 无 CSS 警告。

---

### T-003 · 全局 layout.tsx

**生成文件：**
```
app/layout.tsx
components/layout/Navbar.tsx
components/layout/Footer.tsx
```

**关键实现要点：**
- `layout.tsx` 加载 Geist 字体（Next.js `next/font/google`）
- `Navbar` 初期为静态占位，Phase 3 添加滚动效果
- `Footer` 包含版权信息 + 社交链接占位

---

### T-004 · lib/data/profile.ts

**生成文件：**
```
lib/data/profile.ts
lib/types/index.ts    ← 所有类型定义集中在此
```

---

### T-005 · lib/data/projects.ts

**生成文件：**
```
lib/data/projects.ts
```

**示例数据结构：**
```typescript
export interface Project {
  slug: string
  title: string
  description: string
  tags: string[]
  coverImage: string
  liveUrl?: string
  repoUrl?: string
  featured: boolean
  year: number
}
```

---

### T-006 · Hero Section 组件

**生成文件：**
```
components/sections/HeroSection.tsx
app/page.tsx               ← 引用 HeroSection
```

**实现要点：**
- 纯 Server Component（无交互）
- 展示：姓名、职位、一句话简介、两个 CTA 按钮（查看作品 / 联系我）
- 响应式：移动端居中，桌面端左对齐或居中

---

## 6. LOGS.md 追加格式

每次生成任务完成后，向 `LOGS.md` 追加一条记录，格式如下：

```markdown
## [YYYY-MM-DD HH:mm] T-XXX · 任务标题

**执行者**: Generator 代理
**状态**: ✅ 完成 / 🚫 阻塞 / ⚠️ 待修复

**生成文件**:
- `path/to/file.tsx` — 说明

**关键决策**:
- 选择 Server Component 而非 Client Component，原因：无交互需求，减少 JS bundle
- 使用 `...` 而非 `...`，原因：...

**已知限制 / TODO**:
- [ ] Phase 3 替换占位颜色 Token
```

---

## 7. Generator → Evaluator 移交协议

```
REVIEW_REQUEST {
  task_id:   "T-006",
  task_title: "Hero Section 组件",
  files_changed: [
    "components/sections/HeroSection.tsx",
    "app/page.tsx"
  ],
  acceptance_criteria: [
    "姓名、职位、CTA 按钮正确渲染",
    "移动端 (375px) 布局无溢出",
    "tsc --noEmit 通过",
    "无 console.error"
  ],
  notes: "暂无动画，Phase 3 补充；Avatar 使用占位图"
}
```

---

## 8. 错误处理与升级规则

| 情况 | Generator 行为 |
|---|---|
| 依赖任务未完成 | 标记当前任务为 🚫，记录阻塞原因到 LOGS.md，通知 Orchestrator |
| Evaluator 返回 FIX | 修复并重新提交，最多 **2 次** |
| 超过 2 次仍未通过 | 标记任务为 🚫，升级给 Planner，附带失败原因和建议的重规划方向 |
| 发现 ARCHITECTURE.md 有误 | **不擅自修改**，向 Planner 提 Issue，等待更新后重新生成 |
| TypeScript 编译错误 | 自修复后再标记 ✅，不将编译错误产物移交 Evaluator |

---

## 9. 代理协作全景图（Generator 视角）

```
┌─────────────────────────────────────────────────────┐
│                    Orchestrator                      │
└──────────────────────┬──────────────────────────────┘
                       │
         ┌─────────────▼──────────────┐
         │       PLANNER AGENT        │
         │  HANDOFF → TASKS.md 就绪   │
         └─────────────┬──────────────┘
                       │ HANDOFF
                       ▼
         ┌─────────────────────────────┐
         │      GENERATOR AGENT        │  ← 当前文档
         │                             │
         │  Step 1: 读取 TASKS.md      │
         │  Step 2: 逐任务生成代码      │
         │  Step 3: 更新 TASKS / LOGS  │
         │  Step 4: 发出 REVIEW_REQUEST│
         └─────────────┬───────────────┘
                       │ 代码产物 + REVIEW_REQUEST
                       ▼
         ┌─────────────────────────────┐
         │      EVALUATOR AGENT        │
         │                             │
         │  → PASS   继续下一任务      │
         │  → FIX(n) 返回修复列表      │
         │  → ESCALATE 升级 Planner    │
         └─────────────────────────────┘
```

---

## 验证
src/app/page.tsx     ← 项目真实首页（非 Next.js 默认）

---

## 10. 更新规则

| 文档 | Generator 是否可写 | 时机 |
|---|---|---|
| `TASKS.md` | ✅ 可写 | 任务状态变更时（🔲→⚙️→✅/🚫） |
| `LOGS.md` | ✅ 可写（仅追加） | 每次任务完成或阻塞后 |
| `ARCHITECTURE.md` | ❌ 只读 | 如有异议 → 通知 Planner |
| `PLAN.md` | ❌ 只读 | 如有异议 → 通知 Planner |
| `GENERATOR_AGENT.md` | ⚠️ 仅限 lead agent / 人类 | 规范本身需要更新时 |

> ⚠️ **单向原则**：Generator 只向 Evaluator 提交，不直接修改 Planner 的输出文档。所有向上的反馈须经由 Orchestrator 或显式升级流程。

---

*由 Generator 代理规范文档 · 版本 v0.1 · 与 PLANNER_AGENT.md v0.1 配套使用*
