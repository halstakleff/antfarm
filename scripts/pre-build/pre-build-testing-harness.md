# Pre-Build: Testing Harness

## Purpose

Test infrastructure: unit, integration, E2E.

## Step-by-Step

### Step 1: Unit Tests
```bash
opencode run --agent "setup unit tests: Jest/Vitest, coverage thresholds" --file tests/unit/setup.ts
```

### Step 2: Integration Tests
```bash
opencode run --agent "integration tests: database, API endpoints" --file tests/integration/setup.ts
```

### Step 3: E2E Tests
```bash
opencode run --agent "E2E tests: Playwright/Cypress" --file tests/e2e/setup.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - tests/
RL_SCORE: 95
```
