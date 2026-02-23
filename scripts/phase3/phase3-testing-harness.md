# Phase 3: Testing Harness

## Purpose

Full test infrastructure with fixtures and mocks.

## Step-by-Step

### Step 1: Test Database
```bash
opencode run --agent "test DB: migrations, seed data, isolation" --file tests/db.ts
```

### Step 2: Fixtures
```bash
opencode run --agent "test fixtures: factory functions, builders" --file tests/fixtures/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - tests/fixtures/
RL_SCORE: 95
NEXT_STEPS: Phase 3e CI/CD
```
