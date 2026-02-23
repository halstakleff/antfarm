# Phase 7: Staging Verification

## Purpose

Staging environment validation before production.

## Step-by-Step

### Step 1: Staging Deploy
```bash
opencode run --agent "deploy to staging: data seeding, smoke tests" --file .github/workflows/staging.yml
```

### Step 2: Verification
```bash
opencode run --agent "staging tests: E2E, integration, performance" --file tests/staging/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - .github/workflows/staging.yml
RL_SCORE: 95
NEXT_STEPS: Phase 7c Production
```
