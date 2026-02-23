# Final Quality Guarantee Checklist

## Purpose

Pre-release quality gate.

## Step-by-Step

### Step 1: Checklist Execution
```bash
opencode run --agent "run final checks: tests, security, performance" --file quality/final-checklist.md
```

### Step 2: Sign-off
```bash
opencode run --agent "quality sign-off: all gates passed" --file quality/sign-off.md
```

## Status Output

```
STATUS: done
RL_SCORE: 98
```
