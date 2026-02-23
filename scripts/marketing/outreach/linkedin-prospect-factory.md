# LinkedIn Prospect Factory

## Purpose
Generate LinkedIn prospects at scale.

## Step-by-Step

### Step 1: Persona Definition
```bash
opencode run --agent "define personas: title, industry, company size, geography" --file outreach/linkedin-personas.md
```

### Step 2: URL Generation
```bash
opencode run --agent "generate URLs: Sales Navigator search with segmentation" --file outreach/linkedin-urls.md
```

### Step 3: Automation
```bash
opencode run --agent "execute: connection requests, follow-ups" --file outreach/linkedin-automation.md
```

## Segmentation Strategy
- By geography (states, metros)
- By industry
- By company size
- By seniority

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Target Accuracy | 30% |
| Volume | 25% |
| Response Rate | 25% |
| Cost Efficiency | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - outreach/linkedin-prospects.csv
RL_SCORE: 95
PROSPECTS_GENERATED: 2500
RESPONSE_RATE: 12%
```
