# Phase 3: Observability Setup

## Purpose

Correlate logs, metrics, traces across the system.

## Step-by-Step

### Step 1: Correlation IDs
```bash
opencode run --agent "propagate correlation IDs: HTTP, jobs, DB" --file observability/correlation.ts
```

### Step 2: Alerting
```bash
opencode run --agent "alert rules: thresholds, notification channels" --file observability/alerting.yml
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - observability/
RL_SCORE: 95
NEXT_STEPS: Phase 3d Testing
```
