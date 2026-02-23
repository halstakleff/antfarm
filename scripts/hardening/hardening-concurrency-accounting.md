# Hardening: Concurrency Accounting

## Purpose

Race condition prevention.

## Step-by-Step

### Step 1: Race Detection
```bash
opencode run --agent "test race conditions: concurrent requests" --file tests/concurrency/races.md
```

### Step 2: Fixes
```bash
opencode run --agent "fix races: locks, transactions" --file src/concurrency/fixes.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - tests/concurrency/
RL_SCORE: 95
```
