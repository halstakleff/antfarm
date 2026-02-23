# Comparison Table Engineering

## Purpose
Build high-converting comparison tables (you vs competitors, you vs alternatives).

## Step-by-Step

### Step 1: Competitor Analysis
```bash
opencode run --agent "analyze 3 competitors: features, pricing, gaps" --file website/competitor-analysis.md
```

### Step 2: Table Structure
```bash
opencode run --agent "build table: columns = you + 2 competitors, rows = key features" --file website/comparison-table.md
```

### Step 3: Visualization
```bash
opencode run --agent "style table: your column highlighted, checkmarks vs X's" --file website/comparison-style.md
```

## Table Best Practices
- 3 columns max (you + 2 alternatives)
- 8-12 rows (key differentiators)
- Your column highlighted
- Use checkmarks (✓) and X's (✗)
- Include "Best For" row
- Add CTA below table

## Schema
```json
{
  "@type": "Table",
  "about": "Comparison of [Product] vs Competitors"
}
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Accuracy | 30% |
| Visual Highlight | 25% |
| Completeness | 20% |
| CTA Integration | 15% |
| Mobile Responsiveness | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/components/ComparisonTable.tsx
  - website/sections/Comparison.tsx
RL_SCORE: 96
COMPETITORS_ANALYZED: 3
```
