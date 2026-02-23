# LLM Visibility Audit

## Purpose
Audit website for LLM visibility and AI search presence.

## Step-by-Step

### Step 1: Citations Check
```bash
opencode run --agent "check citations: is content cited by ChatGPT, Perplexity, Claude?" --file aieo/citations-check.md
```

### Step 2: Entity Consistency
```bash
opencode run --agent "verify entity consistency: same name, description everywhere" --file aieo/entity-consistency.md
```

### Step 3: Content Format
```bash
opencode run --agent "audit format: Q&A, definitions, comparisons - LLM-friendly" --file aieo/format-audit.md
```

## LLM Visibility Factors
- **Citations**: Are you mentioned?
- **Definitions**: Clear entity definitions
- **Q&A**: Question-answer pairs
- **Comparisons**: Tables, pros/cons
- **Freshness**: Recent content
- **Authority**: Quality backlinks

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Citation Presence | 30% |
| Entity Consistency | 25% |
| Content Format | 25% |
| Knowledge Panel | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - aieo/visibility-report.json
RL_SCORE: 94
CITATIONS_FOUND: 12
ENTITY_CONSISTENCY: 98%
```
