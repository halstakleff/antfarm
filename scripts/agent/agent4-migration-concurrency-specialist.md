# Agent 4: Migration/Concurrency Specialist

## Purpose

Safe database migrations with concurrency handling.

## Step-by-Step

### Step 1: Migration Safety
```bash
opencode run --agent "generate safe migrations: backwards compatible" --file agents/migrations/safe-gen.ts
```

### Step 2: Concurrency Checks
```bash
opencode run --agent "check for race conditions" --file agents/migrations/concurrency-check.ts
```

## AGENT HANDOFF

**INPUTS:** schema changes
**OUTPUTS:** migration_scripts

## Status Output

```
STATUS: done
RL_SCORE: 95
```
