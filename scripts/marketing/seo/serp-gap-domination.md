# SERP Gap Domination

## Purpose
Identify and fill SERP gaps to dominate search results.

## Step-by-Step

### Step 1: SERP Analysis
```bash
opencode run --agent "analyze SERPs: what's ranking, content types, gaps" --file seo/serp-analysis.md
```

### Step 2: Gap Identification
```bash
opencode run --agent "identify gaps: questions not answered, formats missing, angles uncovered" --file seo/gap-identify.md
```

### Step 3: Content Creation
```bash
opencode run --agent "create content: fill gaps, better than current results" --file seo/gap-content.md
```

## Gap Types
- **Content type**: Video vs text
- **Depth**: Surface vs comprehensive
- **Angle**: No one addressing pain point
- **Format**: Listicle vs guide
- **Freshness**: Outdated ranking content

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Gap Accuracy | 30% |
| Content Quality | 30% |
| SERP Position | 25% |
| Click-Through Rate | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - seo/serp-gaps.json
  - website/content/
RL_SCORE: 96
GAPS_FILLED: 8
RANKINGS_GAINED: 12
```
