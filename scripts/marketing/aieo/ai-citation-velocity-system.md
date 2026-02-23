# AI Citation Velocity System

## Purpose
Increase citation velocity across LLMs.

## Step-by-Step

### Step 1: Citation Analysis
```bash
opencode run --agent "analyze current citations: where, what, quality" --file aieo/citations-analysis.md
```

### Step 2: Velocity Building
```bash
opencode run --agent "build velocity: PR, thought leadership, backlink building" --file aieo/velocity-build.md
```

### Step 3: Monitoring
```bash
opencode run --agent "monitor: track new citations monthly" --file aieo/citations-monitor.md
```

## Tactics
- Press releases
- Thought leadership
- Expert commentary
- Data studies
- Industry partnerships
- Guest contributions
- Podcast appearances

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Citation Count | 35% |
| Source Quality | 35% |
| Velocity Trend | 20% |
| Entity Coverage | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - aieo/citation-strategy.md
RL_SCORE: 95
CITATIONS_PER_MONTH: +8
```
