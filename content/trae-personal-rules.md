## 技术栈
Next.js + TypeScript + Tailwind CSS · Node.js + Express/NestJS · Prisma + PostgreSQL/MongoDB · pnpm · Vitest/Jest

## 代码规范
- 语义化英文命名，禁止拼音/无意义缩写
- 单一职责，行宽 ≤ 100 字符，优先函数式风格
- 统一 `async/await`，完整处理错误边界
- 禁止 `any`、硬编码密钥、生产环境 `console.log`

## 代码审查重点
安全（注入/XSS/CSRF）· 性能（重复渲染/循环DOM）· 可维护性（复杂度/重复代码）· 边界条件（null/undefined）· 依赖合理性

## 生成代码约束
- 默认含 TypeScript 类型定义
- 新增功能同步生成单元测试
- 不删改已有业务逻辑（未经确认）
- 不过度设计，不引入不兼容依赖

## 测试策略
- **单元测试（Vitest）**：覆盖 `lib/utils/`、`services/`、`api/` 边界条件；跳过简单 CRUD 和 UI 组件
- **E2E（Playwright）**：可选，覆盖注册登录等核心路径