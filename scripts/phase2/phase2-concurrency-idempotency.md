# Phase 2: Concurrency & Idempotency

## Purpose

Address race conditions before they occur. Design for reliability under concurrent load.

## Step-by-Step

### Step 1: Race Condition Analysis
```bash
opencode run --agent "identify potential race conditions: simultaneous updates, duplicate requests, ordering" --file concurrency/races.md
```

### Step 2: Idempotency Design
```bash
opencode run --agent "design idempotency keys: client-generated, server-deduplicated" --file concurrency/idempotency.md
```

### Step 3: Locking Strategy
```bash
opencode run --agent "define locking: optimistic (versioning), pessimistic (row locks), distributed (Redis)" --file concurrency/locking.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - concurrency/idempotency.md
  - concurrency/locking.md
RL_SCORE: 95
NEXT_STEPS: Phase 3 Foundation
```
