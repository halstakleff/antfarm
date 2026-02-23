# Phase 7: Production Launch

## Purpose

Production deployment with rollback plan.

## Step-by-Step

### Step 1: Production Deploy
```bash
opencode run --agent "production deployment: blue/green, canary" --file .github/workflows/production.yml
```

### Step 2: Rollback Plan
```bash
opencode run --agent "prepare rollback: data backups, revert scripts" --file infra/rollback.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - .github/workflows/production.yml
RL_SCORE: 95
NEXT_STEPS: Phase 8 Post-Launch
```
