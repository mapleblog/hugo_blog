# LOGS.md

## 2026-05-10

- Initialized Next.js app under officekit/ and implemented first PDF tool (merge).
- Planned "PDF Split" feature as part of the PDF category (no separate category): added tasks T-004~T-006 with API/UI/registry scope and acceptance criteria.

## [2026-05-10 00:00] T-001 · Initialize Next.js 15 project (pnpm)

**执行者**: Generator 代理
**状态**: ✅ 完成

**修改文件**:
- `officekit/package.json`
- `officekit/next.config.ts`
- `officekit/src/modules/registry.ts`
- `officekit/.eslintrc.json`
- `officekit/pnpm-lock.yaml`

**删除文件**:
- `officekit/package-lock.json`
- `officekit/eslint.config.mjs`

**关键决策**:
- 切换到 pnpm 并添加 `packageManager` 字段，确保依赖安装方式一致
- 启用 typedRoutes，并将工具注册表的 `href` 类型收敛为 Next Route 类型，保证 build 期类型检查通过

## [2026-05-10 00:00] EVAL · T-001 · Initialize Next.js 15 project (pnpm)

**评估者**: Evaluator 代理
**轮次**: 第 1 轮
**结论**: ✅ PASS

**阻断问题数**: 0 / 警告数: 0 / 建议数: 0
**决策摘要**: `pnpm lint`、`pnpm type-check`、`pnpm build` 全部通过；Next.js 版本保持在 15.x 且使用 pnpm-lock.yaml

## [2026-05-10 00:00] T-004 · PDF Split — API (range + per-page zip)

**执行者**: Executor 代理
**状态**: ✅ 完成

**修改文件**:
- `officekit/src/app/api/pdf/split/route.ts`
- `officekit/package.json`
- `officekit/pnpm-lock.yaml`

**关键决策**:
- 新增 `jszip` 作为 ZIP 生成依赖，`each_page` 模式返回每页 PDF 的 ZIP
- `range` 模式使用 1-based `start`/`end`（含边界）并做页数范围校验，非法输入统一返回 400

## [2026-05-10 00:00] T-005 · PDF Split — UI page

**执行者**: Executor 代理
**状态**: ✅ 完成

**修改文件**:
- `officekit/src/app/pdf/split/page.tsx`

**关键决策**:
- 复用现有页面交互范式（上传 → 调用 API → 触发下载），支持 `each_page` 下载 ZIP 与 `range` 下载 PDF
- 错误提示优先解析 JSON `{ error }`，避免正常流程的 console.error

## [2026-05-10 00:00] T-006 · Register PDF Split under PDF category

**执行者**: Executor 代理
**状态**: ✅ 完成

**修改文件**:
- `officekit/src/modules/registry.ts`

**关键决策**:
- 将 `PDF Split` 以 `category: "PDF"` 注册到模块注册表，使首页卡片与 `/pdf/split` 路由对齐

## [2026-05-10 00:00] T-007 · PDF Compress (UI + API + registry)

**执行者**: Executor 代理
**状态**: ✅ 完成

**修改文件**:
- `officekit/src/app/api/pdf/compress/route.ts`
- `officekit/src/app/pdf/compress/page.tsx`
- `officekit/src/modules/registry.ts`
- `TASKS.md`
- `TODO.md`
- `STATUS.md`

**关键决策**:
- 使用 pdf-lib 对输入 PDF 进行“重写/重建”（copy pages → 新文档 → save），在不引入外部二进制依赖的前提下尽可能缩小文件体积
- API 通过响应头 `X-Original-Bytes` / `X-Result-Bytes` 返回前后字节数，UI 展示压缩结果并下载 `compressed.pdf`
