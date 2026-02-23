# Hardening: Data Migrations

## Purpose

Safe data migrations with rollback.

## Step-by-Step

### Step 1: Migration Safety
```bash
opencode run --agent "safe migrations: backups, dry runs" --file migrations/safety.md
```

### Step 2: Rollback
```bash
opencode run --agent "rollback scripts: data recovery" --file migrations/rollback/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - migrations/safety.md
RL_SCORE: 95
```
