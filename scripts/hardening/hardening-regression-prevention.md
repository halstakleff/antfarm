# Hardening: Regression Prevention

## Purpose

Prevent future regressions.

## Step-by-Step

### Step 1: Regression Tests
```bash
opencode run --agent "regression tests: reproduce bugs" --file tests/regression/
```

### Step 2: Smoke Tests
```bash
opencode run --agent "smoke tests: critical path" --file tests/smoke/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - tests/regression/
RL_SCORE: 95
```
