# TASKS.md

## Active Tasks

| ID | Title | Status | Acceptance Criteria |
|---|---|---|---|
| T-001 | Initialize Next.js 15 project (pnpm) | ✅ | `pnpm dev` runs; `pnpm build` passes; uses Next.js 15; lockfile is `pnpm-lock.yaml` (no `package-lock.json`) |
| T-002 | Module registry + home navigation | ✅ | Home lists tools from registry; internal links work |
| T-003 | PDF Merge (UI + API) | ✅ | Upload multiple PDFs; server merges via `/api/pdf/merge`; downloads merged.pdf; `pnpm build` passes |
| T-004 | PDF Split — API (range + per-page zip) | ✅ | Adds a ZIP library (e.g. `jszip`); `POST /api/pdf/split` accepts multipart: `file` (PDF), `mode` (`range`/`each_page`); range mode returns a PDF with correct pages; each_page mode returns a ZIP containing per-page PDFs; invalid inputs return 400; `pnpm build` passes |
| T-005 | PDF Split — UI page | ✅ | `/pdf/split` uploads a PDF, selects mode and (if range) start/end pages; triggers download of PDF/ZIP; loading + error states render; no console.error in normal flow |
| T-006 | Register PDF Split under PDF category | ✅ | Home shows "PDF Split" card under `category: "PDF"`; link navigates to `/pdf/split`; `pnpm build` passes |
| T-007 | PDF Compress (UI + API + registry) | ✅ | `POST /api/pdf/compress` accepts multipart: `file` (PDF) and returns `compressed.pdf`; `/pdf/compress` uploads a PDF and triggers download; home shows "PDF Compress" card under `category: "PDF"`; invalid inputs return 400; `pnpm build` passes |

## Notes

- Status legend: 🔲 todo · ⚙️ in progress · ✅ done (awaiting/with evaluator verification)

