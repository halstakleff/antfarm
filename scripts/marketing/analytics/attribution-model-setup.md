# Attribution Model Setup

## Purpose
Set up multi-touch attribution for accurate marketing ROI.

## Step-by-Step

### Step 1: Model Selection
```bash
opencode run --agent "select model: first-touch, last-touch, linear, time-decay, data-driven" --file analytics/attribution-model.md
```

### Step 2: Implementation
```bash
opencode run --agent "implement: GA4, UTM tracking, touchpoint logging" --file analytics/attribution-impl.md
```

### Step 3: Validation
```bash
opencode run --agent "validate: accuracy, completeness" --file analytics/attribution-validate.md
```

## Attribution Models
- First-touch
- Last-touch
- Linear
- Time-decay
- Position-based
- Data-driven

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Model Fit | 30% |
| Accuracy | 30% |
| Data Quality | 20% |
| Actionability | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - analytics/attribution-config.json
RL_SCORE: 95
MODEL: data-driven
TRACKED_TOUCHPOINTS: 12
```
