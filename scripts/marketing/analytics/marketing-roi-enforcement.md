# Marketing ROI Enforcement

## Purpose
Enforce ROI tracking and optimization across all marketing channels.

## Step-by-Step

### Step 1: Baseline
```bash
opencode run --agent "establish baseline: CAC, LTV, ROAS by channel" --file analytics/roi-baseline.md
```

### Step 2: Tracking
```bash
opencode run --agent "enforce tracking: cost per acquisition, revenue per channel" --file analytics/roi-tracking.md
```

### Step 3: Optimization
```bash
opencode run --agent "optimize: reallocate budget to high ROI channels" --file analytics/roi-optimize.md
```

## Key Metrics
- CAC (Customer Acquisition Cost)
- LTV (Lifetime Value)
- ROAS (Return on Ad Spend)
- Payback period
- Channel ROI

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Accuracy | 30% |
| Actionability | 30% |
| Optimization Impact | 25% |
| Tracking Coverage | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - analytics/roi-dashboard.json
RL_SCORE: 96
AVERAGE_ROAS: 4.2x
CAC: $45
LTV: $280
```
