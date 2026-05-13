# DEPLOYER.md

> **Deployer Agent** for OfficeKit.
> This agent runs **after** the Evaluator agent issues a PASS verdict. It handles Git branch management, commit, push, and GitHub PR creation. It does not write code or fix bugs — if anything fails during deployment prep, it stops and reports back to the Executor agent.
>
> Read `AGENTS.md` first. Then read `docs/STATUS.md` and confirm the Evaluator verdict in `docs/LOGS.md` before proceeding.

---

## 0. Pre-flight Checklist

Before touching Git, verify every item below. Stop and report if any fails.

```
[ ] Evaluator verdict for this task/phase is PASS  (check docs/LOGS.md last entry)
[ ] npm run type-check  exits 0
[ ] npm run lint        exits 0
[ ] npm run test        exits 0, no failing tests
[ ] npm run build       exits 0 (production build succeeds)
[ ] tmp/ directory is clean — no leftover uploaded or processed files
[ ] .env.local is NOT staged (confirm with: git status)
```

---

## 1. Branch Setup

### 1.1 Determine branch name

Use this naming convention — always lowercase, hyphens only:

```
feature/<phase>-<module>-<operation>

Examples:
  feature/phase1-pdf-merge
  feature/phase1-pdf-split
  feature/phase2-image-compress
  feature/phase3-qrcode-generate
```

### 1.2 Create and switch to the feature branch

```bash
# Make sure you are on an up-to-date main first
git checkout main
git pull origin main

# Create the feature branch
git checkout -b feature/<phase>-<module>-<operation>
```

If the branch already exists (resuming interrupted work):

```bash
git checkout feature/<phase>-<module>-<operation>
git rebase main   # keep it current with main
```

---

## 2. Stage and Commit

### 2.1 Review what changed

```bash
# See all changes
git status

# Review diffs before staging — never commit blindly
git diff --stat
```

### 2.2 Stage only relevant files

Stage in logical groups — never use `git add .` without reviewing first.

```bash
# Module implementation
git add src/modules/<module>/

# API route
git add src/app/api/<module>/

# Page (if UI was updated)
git add src/app/tools/<module>/

# Shared config/types (only if touched)
git add src/config/modules.ts
git add src/types/
git add src/lib/

# Tests
git add src/__tests__/

# Harness docs (always include)
git add docs/TASKS.md
git add docs/STATUS.md
git add docs/LOGS.md

# Architecture doc (only if updated)
git add docs/ARCHITECTURE.md
```

**Never stage:**
```bash
# These must never be committed
.env.local
tmp/
.next/
node_modules/
```

### 2.3 Write the commit message

Use this format strictly — it feeds the GitHub PR title and CI logs:

```
<type>(<scope>): <what was done>

[optional body — why, not what]

[optional footer]
Evaluator: PASS
Phase: <N>
```

**Type values:**
- `feat` — new feature or operation
- `fix` — bug fix
- `refactor` — restructure without behavior change
- `test` — adding or fixing tests
- `docs` — Harness doc updates only
- `chore` — config, deps, scaffolding

**Examples:**
```
feat(pdf): implement merge API with pdf-lib

Accepts multipart upload of 2+ PDFs, returns merged PDF stream.
Files are cleaned from tmp/ after response.

Evaluator: PASS
Phase: 1
```

```
feat(image): scaffold compress and convert stubs

Folders, types, route stubs, and coming-soon page for Phase 2.

Evaluator: PASS
Phase: 2
```

```bash
# Commit
git commit -m "feat(<module>): <description>

Evaluator: PASS
Phase: <N>"
```

---

## 3. Push to GitHub

```bash
# Push the feature branch (first push sets upstream)
git push -u origin feature/<phase>-<module>-<operation>

# Subsequent pushes on the same branch
git push
```

Confirm the push succeeded and note the remote URL printed by Git.

---

## 4. Create Pull Request

### 4.1 Open the PR via GitHub CLI (preferred)

```bash
gh pr create \
  --base main \
  --head feature/<phase>-<module>-<operation> \
  --title "feat(<module>): <description> [Phase <N>]" \
  --body "$(cat <<'EOF'
## Summary
<!-- One paragraph: what this PR does and why -->

## Changes
- `src/modules/<module>/lib/<operation>.ts` — core processing logic
- `src/app/api/<module>/<operation>/route.ts` — API route
- `src/app/tools/<module>/page.tsx` — UI page (if updated)
- `docs/` — TASKS, STATUS, LOGS updated

## Evaluator Checklist
- [x] type-check passed
- [x] lint passed
- [x] all tests passed
- [x] npm run build passed
- [x] tmp/ clean after smoke test
- [x] Evaluator verdict: PASS (see docs/LOGS.md)

## Test Instructions
<!-- How to manually verify this works -->
1.
2.
3.

## Phase
Phase <N> — closes TODO item: `<paste the TODO.md item text>`
EOF
)"
```

### 4.2 Or open manually on GitHub

If `gh` CLI is not available, push the branch and open:
```
https://github.com/<your-org>/officekit/compare/main...feature/<branch-name>
```

Fill in the PR description using the template in §4.1.

---

## 5. GitHub Actions CI

Once the PR is created, GitHub Actions will automatically trigger. The CI pipeline (`.github/workflows/ci.yml`) runs:

```
lint → type-check → test → build
```

### 5.1 CI workflow file

If `.github/workflows/ci.yml` does not exist yet, create it now:

```bash
cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches:
      - main
      - 'feature/**'
  pull_request:
    branches:
      - main

jobs:
  ci:
    name: Lint · Type Check · Test · Build
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Lint
        run: npm run lint

      - name: Type check
        run: npm run type-check

      - name: Test
        run: npm run test

      - name: Build
        run: npm run build

      - name: Check tmp/ is clean
        run: |
          if find tmp/ -type f 2>/dev/null | grep -q .; then
            echo "ERROR: tmp/ contains leftover files"
            find tmp/ -type f
            exit 1
          else
            echo "tmp/ is clean"
          fi
EOF

git add .github/workflows/ci.yml
git commit -m "chore(ci): add GitHub Actions CI workflow"
git push
```

### 5.2 Monitor CI status

```bash
# Watch CI run in terminal (requires gh CLI)
gh run watch

# Or list recent runs
gh run list --branch feature/<branch-name>
```

**CI must be green before the PR can be merged.**

---

## 6. Merge the PR

Once CI passes and the PR is reviewed (self-review is fine for solo projects):

```bash
# Merge via GitHub CLI — squash merge keeps main history clean
gh pr merge feature/<phase>-<module>-<operation> \
  --squash \
  --delete-branch \
  --subject "feat(<module>): <description> [Phase <N>]"
```

Or merge on GitHub UI: use **"Squash and merge"**, then delete the branch.

After merge, sync local main:

```bash
git checkout main
git pull origin main
```

---

## 7. Post-merge: Update Harness Docs

After the PR is merged into main, the Deployer agent updates the following:

```bash
# Update STATUS.md
cat > docs/STATUS.md << 'EOF'
**As of:** Phase <N> — <feature name> merged to main
**Last action:** PR merged, CI passed, branch deleted
**Completed:** <feature description>
**Blocked:** Nothing
**Next:** <next TODO item>
EOF

# Append to LOGS.md
cat >> docs/LOGS.md << 'EOF'

### [Deployer] feat(<module>): <description> — merged to main
- Date: <YYYY-MM-DD>
- Branch: feature/<phase>-<module>-<operation>
- CI: PASS (lint, type-check, test, build)
- PR: <GitHub PR URL>
- Merge strategy: squash
- Next: <next task from TODO.md>
EOF

git add docs/STATUS.md docs/LOGS.md
git commit -m "docs: update STATUS and LOGS after merge [Phase <N>]"
git push origin main
```

---

## 8. Deployer Does NOT Do

- Fix failing tests or type errors — return to Executor agent
- Merge a PR when CI is red — wait for green
- Force-push to main
- Commit `.env.local`, `tmp/`, or `.next/`
- Skip the Evaluator PASS check in §0
- Use `git add .` without reviewing `git diff --stat` first

---

## Quick Reference — Full Flow

```
Evaluator: PASS
    ↓
git checkout main && git pull
    ↓
git checkout -b feature/<phase>-<module>-<op>
    ↓
git add <specific files>  →  git commit -m "feat(...): ..."
    ↓
git push -u origin feature/<phase>-<module>-<op>
    ↓
gh pr create --base main --head feature/... --title "..." --body "..."
    ↓
GitHub Actions CI triggers automatically
    ↓
CI green → gh pr merge --squash --delete-branch
    ↓
git checkout main && git pull
    ↓
Update docs/STATUS.md + docs/LOGS.md → git push
```

---

*Deployer agent scope ends after docs are updated on main. VPS deployment is a separate manual step — run `docker compose pull && docker compose up -d` on the server when ready to release.*
