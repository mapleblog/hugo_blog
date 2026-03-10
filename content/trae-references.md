# Trae Reference

## 修改默认终端配置

- 打开命令面板：`Ctrl + Shift + P`
- 输入并执行：`> Terminal: Select Default Profile`（内部就是调用上面的 Command ID）

如果你想“固定”默认 Profile（不每次手选），在设置里配置：

- `terminal.integrated.defaultProfile.windows`: 例如 `"PowerShell"` / `"Command Prompt"` / `"Git Bash"`（以你机器上实际的 Profile 名称为准）



## 技能所在目录

- 项目技能的相关文件位于 `.trae/skills/` 目录

- 全局技能的相关文件位于本地根目录 `~/.trae/skills`
  
  ```
  File --> Preferences --> Settings --> Rules & Skills --> Skills 
  												         |__ Global    <-- `~/.trae/skills/skill_name/SKILL.md`
    										   	             |__ Project   <-- `.trae/skills/skill_name/SKILL.md`
  ```



## Skills 市场搜索

- https://skillsmp.com/ 
- https://claudemarketplaces.com/
- https://skills.sh/

下载文件夹？ 还是 命令安装？

- ???


## 调用 Skills

- 在聊天框使用 `关键字` 
- 在聊天框指定 `skill 名称` 



## 个人规则

```
File --> Preferences --> Settings --> User Rules
```

#### 技术栈

Next.js + TypeScript + Tailwind CSS · Node.js + Express/NestJS · Prisma + PostgreSQL/MongoDB · pnpm · Vitest/Jest

#### 代码规范

- 语义化英文命名，禁止拼音/无意义缩写
- 单一职责，行宽 ≤ 100 字符，优先函数式风格
- 统一 `async/await`，完整处理错误边界
- 禁止 `any`、硬编码密钥、生产环境 `console.log`

#### 代码审查重点

安全（注入/XSS/CSRF）· 性能（重复渲染/循环DOM）· 可维护性（复杂度/重复代码）· 边界条件（null/undefined）· 依赖合理性

#### 生成代码约束

- 默认含 TypeScript 类型定义
- 新增功能同步生成单元测试
- 不删改已有业务逻辑（未经确认）
- 不过度设计，不引入不兼容依赖

#### 测试策略

- **单元测试（Vitest）**：覆盖 `lib/utils/`、`services/`、`api/` 边界条件；跳过简单 CRUD 和 UI 组件
- **E2E（Playwright）**：可选，覆盖注册登录等核心路径



##  Trae 专属的声明文件

```
你的项目根目录/
└── .trae/
    └── rules/
        └── project_rules.md   ← 放这里
```

> [!TIP]
>
> # Trae Project Rules — 生产级 Vibe Coding 规范
>
> ## 🧠 AI 行为准则
>
> ### 角色定位
>
> 你是一名经验丰富的全栈工程师，专注于生产级 Web 应用开发。 在每次生成代码前，必须先理解当前项目的架构上下文，不得随意引入新的依赖或破坏现有模式。
>
> ### 核心原则
>
> - **一致性优先**：遵循项目已有的代码风格、命名规范和目录结构
> - **最小改动原则**：只修改必要的文件，不做无关重构
> - **可测试性**：所有生成的函数和组件必须易于测试
> - **类型安全**：全程使用 TypeScript，禁止使用 `any`
>
> ------
>
> ## 📁 项目结构规范
>
> ```
> src/
> ├── app/                  # 路由页面（Next.js App Router）
> ├── components/
> │   ├── ui/               # 基础 UI 组件（shadcn/ui）
> │   └── features/         # 业务功能组件
> ├── hooks/                # 自定义 React Hooks
> ├── lib/                  # 工具函数、第三方封装
> ├── services/             # API 请求层（统一管理）
> ├── stores/               # 全局状态（Zustand）
> ├── types/                # 全局 TypeScript 类型定义
> └── test/
>     ├── setup.ts          # 测试环境初始化
>     └── utils/            # 测试工具函数
> ```
>
> ### 文件命名规范
>
> | 类型     | 规范                | 示例                   |
> | -------- | ------------------- | ---------------------- |
> | 组件     | PascalCase          | `UserProfile.tsx`      |
> | Hook     | camelCase + use前缀 | `useAuthUser.ts`       |
> | 工具函数 | camelCase           | `formatDate.ts`        |
> | 类型文件 | camelCase           | `user.types.ts`        |
> | 测试文件 | 同名 + `.test`      | `UserProfile.test.tsx` |
> | 常量文件 | UPPER_SNAKE_CASE    | `API_CONSTANTS.ts`     |
>
> ------
>
> ## 🧩 前端架构规范
>
> ### 组件规范
>
> ```typescript
> // ✅ 正确：函数组件 + 明确的 Props 类型
> interface ButtonProps {
>   label: string
>   onClick: () => void
>   variant?: 'primary' | 'secondary' | 'ghost'
>   disabled?: boolean
> }
> 
> export function Button({ label, onClick, variant = 'primary', disabled = false }: ButtonProps) {
>   return (
>     <button
>       onClick={onClick}
>       disabled={disabled}
>       className={cn(buttonVariants({ variant }))}
>     >
>       {label}
>     </button>
>   )
> }
> 
> // ❌ 禁止：使用 any、内联大量逻辑、不写类型
> export function Button(props: any) { ... }
> ```
>
> ### 状态管理规范
>
> - **局部 UI 状态** → `useState` / `useReducer`
> - **服务端数据缓存** → `TanStack Query`（统一使用，禁止裸 fetch）
> - **全局客户端状态** → `Zustand`（仅存放真正需要全局共享的状态）
> - **表单状态** → `React Hook Form` + `Zod` 验证
>
> ### API 请求规范
>
> ```typescript
> // services/user.service.ts — 所有 API 调用集中在 services 层
> import { apiClient } from '@/lib/api-client'
> import type { User, UpdateUserDto } from '@/types/user.types'
> 
> export const userService = {
>   getById: (id: string) =>
>     apiClient.get<User>(`/users/${id}`),
> 
>   update: (id: string, data: UpdateUserDto) =>
>     apiClient.patch<User>(`/users/${id}`, data),
> }
> 
> // hooks/useUser.ts — 通过 TanStack Query 封装
> export function useUser(id: string) {
>   return useQuery({
>     queryKey: ['user', id],
>     queryFn: () => userService.getById(id),
>     staleTime: 5 * 60 * 1000,
>   })
> }
> ```
>
> ------
>
> ## 🗄️ 数据层规范
>
> ### 数据库操作
>
> - 所有数据库操作必须通过 **Repository 层**，禁止在路由/控制器中直接操作 DB
> - Schema 变更必须通过 **Migration 文件**，禁止直接修改生产表结构
> - 查询必须检查 **N+1 问题**，必要时使用 `include` 或 `select` 优化
>
> ### 数据验证
>
> ```typescript
> // 使用 Zod 在边界处统一验证
> import { z } from 'zod'
> 
> export const CreateUserSchema = z.object({
>   email: z.string().email('邮箱格式不正确'),
>   name: z.string().min(2, '姓名至少2个字符').max(50),
>   role: z.enum(['admin', 'user', 'viewer']),
> })
> 
> export type CreateUserDto = z.infer<typeof CreateUserSchema>
> ```
>
> ------
>
> ## ⚙️ 后端架构规范
>
> ### API 设计
>
> - RESTful 接口遵循语义化 HTTP 方法
> - 统一响应格式：
>
> ```typescript
> // 成功
> { success: true, data: T, message?: string }
> 
> // 失败
> { success: false, error: { code: string, message: string } }
> ```
>
> - 所有接口必须有**速率限制**（Rate Limiting）
> - 分页接口统一使用：`?page=1&limit=20`
>
> ### 错误处理
>
> ```typescript
> // lib/errors.ts — 统一错误类型
> export class AppError extends Error {
>   constructor(
>     public code: string,
>     public message: string,
>     public statusCode: number = 400
>   ) {
>     super(message)
>   }
> }
> 
> export class NotFoundError extends AppError {
>   constructor(resource: string) {
>     super('NOT_FOUND', `${resource} 不存在`, 404)
>   }
> }
> ```
>
> ------
>
> ## 🧪 测试规范（Vitest）
>
> ### 强制要求
>
> - ✅ 每个新组件必须有对应 `.test.tsx` 文件
> - ✅ 每个 `utils/` 和 `services/` 函数必须有单元测试
> - ✅ 测试覆盖率不得低于 **80%**
> - ❌ 禁止提交覆盖率下降的代码
>
> ### 测试文件结构
>
> ```typescript
> // components/Button/Button.test.tsx
> import { render, screen, fireEvent } from '@testing-library/react'
> import { describe, it, expect, vi } from 'vitest'
> import { Button } from './Button'
> 
> describe('Button', () => {
>   it('渲染正确的文本', () => {
>     render(<Button label="点击我" onClick={() => {}} />)
>     expect(screen.getByText('点击我')).toBeInTheDocument()
>   })
> 
>   it('点击时触发 onClick 回调', () => {
>     const handleClick = vi.fn()
>     render(<Button label="点击" onClick={handleClick} />)
>     fireEvent.click(screen.getByRole('button'))
>     expect(handleClick).toHaveBeenCalledOnce()
>   })
> 
>   it('disabled 状态下不触发点击', () => {
>     const handleClick = vi.fn()
>     render(<Button label="点击" onClick={handleClick} disabled />)
>     fireEvent.click(screen.getByRole('button'))
>     expect(handleClick).not.toHaveBeenCalled()
>   })
> })
> ```
>
> ### 自动测试触发节点
>
> ```
> 文件保存    → vitest --watch 即时运行相关测试
> git commit → husky pre-commit 运行全量测试
> git push   → GitHub Actions CI 运行 + 覆盖率报告
> ```
>
> ------
>
> ## 🔐 安全规范
>
> ### 必须遵守
>
> - ❌ 禁止在代码中硬编码密钥、Token、密码
> - ❌ 禁止在日志中输出敏感信息（密码、Token、PII）
> - ❌ 禁止信任客户端传来的用户权限数据
> - ✅ 所有用户输入必须在服务端二次验证
> - ✅ SQL 查询必须使用参数化查询，禁止字符串拼接
> - ✅ 上传文件必须验证类型和大小
>
> ### 环境变量规范
>
> ```bash
> # .env.example（提交到 Git）
> DATABASE_URL=
> NEXTAUTH_SECRET=
> NEXTAUTH_URL=
> 
> # .env.local（禁止提交到 Git，加入 .gitignore）
> DATABASE_URL=postgresql://...
> NEXTAUTH_SECRET=your-secret-here
> ```
>
> ### 认证与授权
>
> ```typescript
> // 每个需要保护的 API 路由必须验证权限
> export async function GET(req: Request) {
>   const session = await getServerSession(authOptions)
>   if (!session) {
>     return Response.json({ error: 'Unauthorized' }, { status: 401 })
>   }
> 
>   // 权限检查
>   if (!hasPermission(session.user.role, 'read:users')) {
>     return Response.json({ error: 'Forbidden' }, { status: 403 })
>   }
> 
>   // ... 业务逻辑
> }
> ```
>
> ------
>
> ## 🔄 架构检查节点
>
> | 节点            | 检查内容                                      |
> | --------------- | --------------------------------------------- |
> | **每次 PR**     | 组件边界、新增依赖合理性、测试是否覆盖        |
> | **每个 Sprint** | Schema 变更审查、Bundle 体积分析、`npm audit` |
> | **每月**        | 权限模型复查、依赖漏洞扫描、日志安全审查      |
> | **重大功能前**  | 专项安全审计、性能基准测试                    |
>
> ------
>
> ## 🚫 AI 生成代码禁止事项
>
> 在 Trae 中，AI 生成代码时**绝对禁止**：
>
> 1. 引入未经确认的新 npm 包（必须先告知开发者）
> 2. 修改 `package.json`、`tsconfig.json`、`.env` 等配置文件，除非明确被要求
> 3. 删除现有测试文件或降低测试覆盖率
> 4. 绕过类型检查（使用 `@ts-ignore`、`as any`）
> 5. 在组件中直接调用 `fetch`，必须通过 `services` 层
> 6. 生成没有错误处理的异步代码
> 7. 提交包含 `console.log` 调试语句的代码



> [!TIP]
>
> # Trae Project Rules - 精简版（ 少于100字数 ）
>
> ## AI 行为准则
>
> - 遵循项目已有代码风格，不随意引入新依赖
> - 全程使用 TypeScript，禁止 `any` 和 `@ts-ignore`
> - 只修改必要文件，不做无关重构
>
> ## 目录结构
>
> ```
> src/
> ├── components/ui/        # 基础组件
> ├── components/features/  # 业务组件
> ├── services/             # 统一 API 层
> ├── hooks/                # 自定义 Hooks
> ├── stores/               # Zustand 全局状态
> └── types/                # TS 类型定义
> ```
>
> ## 代码规范
>
> - 组件必须有明确的 Props 类型定义
> - 禁止在组件中裸调用 `fetch`，统一走 `services/` 层
> - 异步代码必须有错误处理
> - 禁止提交含 `console.log` 的代码
>
> ## 测试规范（Vitest）
>
> - 每个组件和工具函数必须有对应 `.test.ts(x)` 文件
> - 覆盖率不得低于 **80%**
> - 自动触发节点：
>   - 保存时 → `vitest --watch`
>   - commit 前 → husky pre-commit
>   - push 后 → GitHub Actions CI
>
> ## 安全红线
>
> - ❌ 禁止硬编码密钥、Token、密码
> - ❌ 禁止日志输出敏感信息
> - ✅ 所有用户输入必须服务端二次验证
> - ✅ 每个受保护接口必须校验 session 和权限
>
> ## 完成 Checklist
>
> - [ ] `tsc --noEmit` 无报错
> - [ ] `npm run lint` 通过
> - [ ] Vitest 全量测试通过
> - [ ] 覆盖率 ≥ 80%
> - [ ] 无硬编码敏感信息
> - [ ] API 接口有权限校验

 