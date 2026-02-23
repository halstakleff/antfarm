# Phase 7: Release Gate

## Purpose

Go/no-go criteria checklist.

## Step-by-Step

### Step 1: Release Checklist
```bash
opencode run --agent "create release checklist: tests, docs, security, performance" --file release/checklist.md
```

### Step 2: Approval Process
```bash
opencode run --agent "approval gates: stakeholders sign off" --file release/approvals.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - release/checklist.md
RL_SCORE: 95
NEXT_STEPS: Phase 7b Staging
```
