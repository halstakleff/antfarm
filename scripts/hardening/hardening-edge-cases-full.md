# Hardening: Edge Cases

## Purpose

Edge case testing and handling.

## Step-by-Step

### Step 1: Edge Case ID
```bash
opencode run --agent "find edge cases: empty, null, max values, boundary" --file tests/edge/cases.md
```

### Step 2: Handling
```bash
opencode run --agent "implement handlers: graceful degradation" --file src/edge/handlers.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - tests/edge/
RL_SCORE: 95
```
