# Pillar Content Generator

## Purpose
Generate comprehensive pillar content for topic authority.

## Step-by-Step

### Step 1: Topic Selection
```bash
opencode run --agent "select topics: broad, high volume, business relevant" --file content/pillar-topics.md
```

### Step 2: Outline Creation
```bash
opencode run --agent "create outline: H2 sections, clusters, internal links" --file content/pillar-outline.md
```

### Step 3: Content Generation
```bash
opencode run --agent "generate: 3000+ words, comprehensive, authoritative" --file content/pillar-content.md
```

## Pillar Structure
- 3000+ words
- 8-12 H2 sections
- Table of contents
- Internal links to clusters
- CTA every 500 words
- FAQ section
- Summary

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Comprehensiveness | 30% |
| Authority | 25% |
| Internal Links | 20% |
| Engagement | 15% |
| Length | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - content/pillars/
RL_SCORE: 96
PILLARS_CREATED: 3
AVG_LENGTH: 4200
```
