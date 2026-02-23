# Phase 8: Post-Launch Monitoring

## Purpose

Production monitoring, alerting, SLOs.

## Step-by-Step

### Step 1: Dashboards
```bash
opencode run --agent "setup dashboards: Grafana, Datadog" --file observability/dashboards/
```

### Step 2: Alerting
```bash
opencode run --agent "alert rules: SLIs, SLOs, error rates" --file observability/alerts/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - observability/dashboards/
RL_SCORE: 95
NEXT_STEPS: Phase 8b Debt
```
