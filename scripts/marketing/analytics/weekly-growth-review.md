# Weekly Growth Review

## Purpose
Weekly review of marketing growth metrics.

## Step-by-Step

### Step 1: Data Collection
```bash
opencode run --agent "collect: traffic, conversions, revenue, channel performance" --file analytics/weekly-data.md
```

### Step 2: Analysis
```bash
opencode run --agent "analyze: trends, anomalies, opportunities" --file analytics/weekly-analysis.md
```

### Step 3: Report
```bash
opencode run --agent "generate: weekly report with action items" --file analytics/weekly-report.md
```

## Metrics Tracked
- Traffic by source
- Conversion rate
- Revenue
- CAC by channel
- ROAS
- Pipeline
- Qualified leads

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Data Completeness | 30% |
| Insight Quality | 30% |
| Actionability | 25% |
| Timeliness | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - analytics/weekly-report.md
RL_SCORE: 95
WEEK_ENDING: 2026-02-22
GROWTH_WoW: +12%
```
