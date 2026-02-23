# Phase 4: Commit Standard

## Purpose

Conventional commits with changelog generation.

## Step-by-Step

### Step 1: Commit Lint
```bash
opencode run --agent "enforce conventional commits: feat:, fix:, docs:" --file .github/commitlint.yml
```

### Step 2: Changelog
```bash
opencode run --agent "auto-generate CHANGELOG from commits" --file .github/workflows/changelog.yml
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - CHANGELOG.md
RL_SCORE: 95
NEXT_STEPS: Phase 5 Hardening
```
