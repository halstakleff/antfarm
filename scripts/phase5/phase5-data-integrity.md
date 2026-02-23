# Phase 5: Data Integrity

## Purpose

Constraints, constraints, constraints at every layer.

## Step-by-Step

### Step 1: DB Constraints
```bash
opencode run --agent "DB constraints: not null, unique, foreign keys" --file migrations/integrity.sql
```

### Step 2: App Validation
```bash
opencode run --agent "app-level validation: business rules" --file src/domain/validation.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - migrations/integrity.sql
RL_SCORE: 95
NEXT_STEPS: Phase 5c Security
```
