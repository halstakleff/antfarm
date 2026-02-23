# Funnel Dropoff Analysis

## Purpose
Analyze conversion funnel and identify dropoff points.

## Step-by-Step

### Step 1: Funnel Mapping
```bash
opencode run --agent "map funnel: steps, dropoffs, conversion rates" --file cro/funnel-map.md
```

### Step 2: Analysis
```bash
opencode run --agent "analyze: where, why, how much" --file cro/funnel-analysis.md
```

### Step 3: Fixes
```bash
opencode run --agent "implement: fixes to reduce dropoff" --file cro/funnel-fixes.md
```

## Funnel Stages
1. Visitors
2. Product page views
3. Pricing page views
4. Sign-ups
5. Activations
6. Paid conversions

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Dropoff Identification | 30% |
| Fix Effectiveness | 30% |
| Conversion Lift | 25% |
| Accuracy | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - cro/funnel-report.json
RL_SCORE: 95
DROPOFF_POINTS: 3
CONVERSION_LIFT: +18%
```
