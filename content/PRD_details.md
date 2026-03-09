# 项目开发细节事项

### 开发前

拟定项目需求

- **项目名**



- **项目需求描述**



- **技术栈**

  - **前端**：Next.js + TypeScript + Tailwind CSS

  - **后端**：Node.js + Express / NestJS

  - **管理包**：用 **pnpm**，原因上面聊过了——速度快、省磁盘、避免幽灵依赖，Next.js 生态完全兼容。

  - **安全验证**：

    - 认证（Authentication）

      | 工具           | 用途                                                |
      | -------------- | --------------------------------------------------- |
      | NextAuth.js v5 | 首选，内置 OAuth、JWT、Session，与 Next.js 深度集成 |
      | Clerk          | 开箱即用 UI + 后端，适合快速上线，有免费额度        |
      | Lucia          | 轻量自定义，适合想完全掌控认证逻辑的场景            |

    - **推荐：NextAuth.js v5**，原因是免费、开源、与 Prisma Adapter 直接集成，社区最成熟

    - **授权（Authorization）**

      ```typrescript
      // middleware.ts — 路由级别保护
      export { auth as middleware } from "@/lib/auth"
      
      export const config = {
        matcher: ["/dashboard/:path*", "/api/v1/:path*"]
      }
      ```

      | 层级     | 方式                                 |
      | -------- | ------------------------------------ |
      | 路由保护 | `middleware.ts` 拦截未登录请求       |
      | API保护  | Route Handler 内校验 Session/Token   |
      | 数据权限 | Service 层校验用户只能操作自己的数据 |

      **数据验证**

      ```typescript
      // schemas/user.schema.ts
      import { z } from "zod"
      
      export const createUserSchema = z.object({
        email: z.string().email(),
        password: z.string().min(8).max(100),
        name: z.string().min(1).max(50),
      })
      
      // API Route 使用
      const body = createUserSchema.safeParse(await req.json())
      if (!body.success) {
        return Response.json({ error: body.error.flatten() }, { status: 400 })
      }
      ```

      **密码安全**

      ```typrescript
      import bcrypt from "bcryptjs"
      
      // 存储时加密
      const hashed = await bcrypt.hash(password, 12)
      
      // 验证时比对
      const valid = await bcrypt.compare(password, hashed)
      ```

      **API 安全**

      | 措施         | 工具                              |
      | ------------ | --------------------------------- |
      | 请求频率限制 | **Upstash Rate Limit** + Redis    |
      | CSRF 保护    | NextAuth 内置 / `csrf` 库         |
      | HTTP 安全头  | `next.config.ts` 配置 `headers()` |
      | 依赖漏洞扫描 | pnpm audit                        |

      ```typescript
      // next.config.ts — 安全 HTTP Headers
      const securityHeaders = [
        { key: "X-Frame-Options", value: "DENY" },
        { key: "X-Content-Type-Options", value: "nosniff" },
        { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
        { key: "Permissions-Policy", value: "camera=(), microphone=()" },
      ]
      ```

      **环境变量管理**

      ````bash
      # .env.example（提交 Git，不含真实值）
      DATABASE_URL=
      NEXTAUTH_SECRET=
      NEXTAUTH_URL=
      REDIS_URL=
      
      # 生成 NEXTAUTH_SECRET
      openssl rand -base64 32
      ```
      
      ---
      
      **完整安全验证层级总结**
      ```
      请求进入
        ↓
      HTTP Headers 安全头（next.config.ts）
        ↓
      Rate Limiting 频率限制（middleware）
        ↓
      认证检查 NextAuth Session（middleware）
        ↓
      Zod 数据校验（Route Handler）
        ↓
      授权检查 用户权限（Service 层）
        ↓
      业务逻辑执行
      ````



- **数据库**

  - **数据栈采用**

    - | 场景                | 推荐                 | 理由                                |
      | ------------------- | -------------------- | ----------------------------------- |
      | 通用 Web 应用       | PostgreSQL           | 功能最全、Prisma 支持最好、生产可靠 |
      | 快速原型 / 本地开发 | SQLite               | 零配置，Prisma 直接支持             |
      | 高并发读写          | PostgreSQL + Redis   | Redis 做缓存层                      |
      | 边缘部署            | PlanetScale 或 Turso | 分布式、低延迟                      |

    - PostgreSQL（生产）+ SQLite（本地开发）（ **两者都用 Prisma 管理，只需切换 `DATABASE_URL`，开发体验顺滑。**）

  - **数据结构设计**

    - 根据**具体业务场景**来定，不同项目的实体和关系差异很大
      - 电商平台
      - Saas管理平台
      - 烘培网站，咖啡餐厅，奶茶网站
      - 宠物店，企业网站，护肤产品网站
      - 手机端 apps



- **规范要求**

  - **代码质量**

    - **ESLint** — 使用 `eslint-config-next` 官方规则集，禁止 `any` 类型、未使用变量
    - **Prettier** — 统一格式化，单引号、2空格缩进、尾逗号
    - **eslint-plugin-tailwindcss** — Tailwind class 自动排序，检测无效 class
    - **TypeScript strict mode** — `tsconfig.json` 开启 `"strict": true`，全栈强类型约束

  - **数据验证**

    - **Zod** — 所有 API 入参、表单数据必须经过 Schema 验证，禁止裸用 `req.body`

  - **提交规范**

    - **Commitlint** — commit message 遵循 Conventional Commits 格式

      ```md
      feat: 新功能
      fix: 修复 bug
      chore: 构建/依赖变更
      docs: 文档更新
      refactor: 重构
      test: 测试相关
      ```

    - **Husky + lint-staged** — 提交前自动运行 ESLint + Prettier，不通过禁止提交

  - **数据库规范**

    - **prisma-lint** — Prisma Schema 命名统一（Model 用 PascalCase，字段用 camelCase）
    - 所有 Schema 变更必须通过 `prisma migrate` 版本管理，禁止直接改数据库

  - **安全规范**

    - 敏感信息（密钥、数据库连接串）统一放 `.env.local`，禁止提交到 Git
    - API 路由统一使用 **Zod** 校验 + **JWT/NextAuth** 鉴权
    - 依赖定期用 `pnpm audit` 扫描漏洞

  - **分支规范**

    ```md
    main          # 生产环境，只接受 PR 合并
    develop       # 开发主分支
    feat/xxx      # 功能分支
    fix/xxx       # 修复分支
    ```



- **目录结构**（Next.js App Router + Prisma + 生产级规范）

  ```
  project-root/
  ├── .husky/                        # Git hooks
  │   ├── pre-commit                 # lint-staged
  │   └── commit-msg                 # commitlint
  │
  ├── .github/
  │   └── workflows/
  │       ├── ci.yml                 # PR 自动测试
  │       └── deploy.yml             # 自动部署
  │
  ├── prisma/
  │   ├── schema.prisma              # 数据库 Schema
  │   ├── migrations/                # 迁移版本记录
  │   └── seed.ts                    # 种子数据
  │
  ├── src/
  │   ├── app/                       # Next.js App Router
  │   │   ├── (auth)/                # 路由分组 - 认证页面
  │   │   │   ├── login/
  │   │   │   └── register/
  │   │   ├── (dashboard)/           # 路由分组 - 主应用
  │   │   │   ├── layout.tsx
  │   │   │   └── page.tsx
  │   │   ├── api/                   # Route Handlers
  │   │   │   └── v1/
  │   │   │       ├── users/
  │   │   │       │   └── route.ts
  │   │   │       └── auth/
  │   │   │           └── route.ts
  │   │   ├── layout.tsx             # Root Layout
  │   │   ├── page.tsx               # 首页
  │   │   └── globals.css            # 全局样式
  │   │
  │   ├── components/                # React 组件
  │   │   ├── ui/                    # 基础 UI 组件 (shadcn/ui)
  │   │   │   ├── button.tsx
  │   │   │   ├── input.tsx
  │   │   │   └── modal.tsx
  │   │   ├── forms/                 # 表单组件
  │   │   ├── layouts/               # 布局组件
  │   │   └── shared/                # 跨页面复用组件
  │   │
  │   ├── lib/                       # 核心工具库
  │   │   ├── prisma.ts              # Prisma Client 单例
  │   │   ├── auth.ts                # NextAuth 配置
  │   │   ├── redis.ts               # Redis 连接
  │   │   └── utils.ts               # 通用工具函数
  │   │
  │   ├── services/                  # 业务逻辑层
  │   │   ├── user.service.ts
  │   │   └── auth.service.ts
  │   │
  │   ├── repositories/              # 数据库操作层
  │   │   ├── user.repository.ts
  │   │   └── base.repository.ts
  │   │
  │   ├── schemas/                   # Zod 验证 Schema
  │   │   ├── user.schema.ts
  │   │   └── auth.schema.ts
  │   │
  │   ├── hooks/                     # React 自定义 Hooks
  │   │   ├── useAuth.ts
  │   │   └── useUser.ts
  │   │
  │   ├── stores/                    # 状态管理 (Zustand)
  │   │   └── auth.store.ts
  │   │
  │   ├── types/                     # 全局 TypeScript 类型
  │   │   ├── api.types.ts
  │   │   └── index.ts
  │   │
  │   ├── constants/                 # 常量定义
  │   │   └── index.ts
  │   │
  │   └── middleware.ts              # Next.js 中间件 (鉴权路由保护)
  │
  ├── tests/
  │   ├── unit/                      # Vitest 单元测试
  │   │   ├── services/
  │   │   └── utils/
  │   ├── integration/               # Vitest 集成测试
  │   │   └── api/
  │   └── e2e/                       # Playwright E2E 测试
  │       └── auth.spec.ts
  │
  ├── public/                        # 静态资源
  │   ├── icons/
  │   └── images/
  │
  ├── .env.example                   # 环境变量模板（提交 Git）
  ├── .env.local                     # 实际环境变量（不提交 Git）
  ├── .eslintrc.json
  ├── .prettierrc
  ├── commitlint.config.js
  ├── tailwind.config.ts
  ├── tsconfig.json
  ├── vitest.config.ts
  ├── playwright.config.ts
  ├── next.config.ts
  └── package.json
  ```

  - **核心分层逻辑**

    `Request → Route Handler → Service → Repository → Prisma → Database`

    - **Route Handler** — 只负责接收请求、调用 Service、返回响应
    
    - **Service** — 业务逻辑，不直接碰数据库
    
    - **Repository** — 所有 Prisma 查询集中在这里，Service 不直接用 Prisma
    
      ```markdown
      ## 8. 测试策略
      
      ### 单元测试（Vitest）
      **覆盖范围：** 业务逻辑层、工具函数、数据转换
      **触发时机：** 完成 Service 层和 utils/ 后编写
      
      需测试模块：
      - `lib/utils/` - 格式化、校验、计算函数
      - `services/` - 核心业务逻辑
      - `api/` - 重要接口的边界条件和错误处理
      
      跳过测试：
      - UI 组件（手动验证）
      - 简单 CRUD 接口（无复杂业务规则）
      
      ### E2E 测试（Playwright）- 可选
      覆盖核心用户路径：注册登录、主流程操作
      ```
    
      



- **框架测试**
  - **单元/集成测试**：**Vitest**	# 业务逻辑、API Route、工具函数
  - **组件测试**：**Vitest + Testing Library**	# React 组件渲染和交互
  - **数据库测试**：**Vitest + Prisma**	# 配合测试数据库或 mock
  - **E2E 测试**：**Playwright**	# 全链路用户流程测试