# Phase 8: Continuous Quality Loop

## Purpose

Feedback integration and iteration.

## Step-by-Step

### Step 1: Feedback Collection
```bash
opencode run --agent "feedback channels: support tickets, metrics" --file quality/feedback/
```

### Step 2: Iteration Planning
```bash
opencode run --agent "prioritize improvements: impact, effort" --file quality/backlog/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - quality/backlog/
RL_SCORE: 95
```
