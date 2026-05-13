# ARCHITECTURE.md

## Overview

- App: OfficeKit (no-login office utilities)
- Stack: Next.js 15 (App Router) + TypeScript + Tailwind CSS v4 + pnpm
- Server-side processing: pdf-lib (PDF) and sharp (images)

## Repository Layout

- officekit/ (Next.js application)
- AGENTS.md (workflow entry point)
- ARCHITECTURE.md (this file)
- PLAN.md (milestones/phases)
- TODO.md (backlog)
- TASKS.md (in-flight work)
- STATUS.md (current snapshot)
- LOGS.md (append-only decisions/actions)

## Modules

- Registry: officekit/src/modules/registry.ts

## API

- PDF merge: POST /api/pdf/merge (multipart form-data: files[])

