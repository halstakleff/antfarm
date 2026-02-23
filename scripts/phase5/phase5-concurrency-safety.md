# Phase 5: Concurrency Safety

## Purpose

Locking, transactions, distributed safety.

## Step-by-Step

### Step 1: Transaction Boundaries
```bash
opencode run --agent "transaction boundaries: ACID compliance" --file src/infra/transactions/
```

### Step 2: Distributed Locks
```bash
opencode run --agent "distributed locking: Redis, advisory locks" --file src/infra/locking/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/infra/transactions/
RL_SCORE: 95
NEXT_STEPS: Phase 6 UI
```
