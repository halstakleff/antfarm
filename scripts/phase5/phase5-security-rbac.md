# Phase 5: Security & RBAC

## Purpose

Permission enforcement at every layer.

## Step-by-Step

### Step 1: Permission Checks
```bash
opencode run --agent "RBAC enforcement: decorator/middleware for every route" --file src/auth/guards/
```

### Step 2: Audit Logging
```bash
opencode run --agent "audit log: who accessed what, when" --file src/audit/logger.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/auth/guards/
RL_SCORE: 95
NEXT_STEPS: Phase 5d Concurrency
```
