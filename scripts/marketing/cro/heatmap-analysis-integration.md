# Heatmap Analysis Integration

## Purpose
Integrate and analyze heatmap data.

## Step-by-Step

### Step 1: Heatmap Setup
```bash
opencode run --agent "setup: Hotjar, Clarity, Mouseflow" --file cro/heatmap-setup.md
```

### Step 2: Analysis
```bash
opencode run --agent "analyze: click maps, scroll maps, rage clicks" --file cro/heatmap-analysis.md
```

### Step 3: Optimize
```bash
opencode run --agent "optimize: CTA placement, form length, content priority" --file cro/heatmap-optimize.md
```

## Insights
- Dead clicks
- Scroll depth
- CTA visibility
- Form friction
- Navigation issues

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Insight Quality | 30% |
| Fix Priority | 25% |
| Implementation | 25% |
| Impact | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - cro/heatmap-report.json
RL_SCORE: 94
INSIGHTS_FOUND: 12
IMPACT_LIFT: +11%
```
