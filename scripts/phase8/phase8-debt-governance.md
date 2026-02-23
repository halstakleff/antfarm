# Phase 8: Debt Governance

## Purpose

Technical debt tracking and triage.

## Step-by-Step

### Step 1: Debt Register
```bash
opencode run --agent "track debt: TODO comments, FIXME, performance issues" --file debt/register.md
```

### Step 2: Triage
```bash
opencode run --agent "debt triage: S0/S1/S2 severity" --file debt/triage.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - debt/register.md
RL_SCORE: 95
NEXT_STEPS: Phase 8c Quality
```
