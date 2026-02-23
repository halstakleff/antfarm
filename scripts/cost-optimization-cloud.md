# Cost Optimization Cloud

## Purpose

Optimize cloud spend.

## Step-by-Step

### Step 1: Cost Audit
```bash
opencode run --agent "audit costs: compute, storage, egress" --file cost/audit.md
```

### Step 2: Optimization
```bash
opencode run --agent "optimize: reserved instances, cleanup" --file cost/optimize.md
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
