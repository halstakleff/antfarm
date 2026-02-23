# AI-Optimized Content Formatting

## Purpose
Format content for optimal LLM parsing and citation.

## Step-by-Step

### Step 1: Content Audit
```bash
opencode run --agent "audit content: structure, formatting, LLM-friendliness" --file aieo/content-audit.md
```

### Step 2: Format Optimization
```bash
opencode run --agent "optimize: clear headings, bullet lists, Q&A, tables" --file aieo/format-optimize.md
```

### Step 3: Schema Integration
```bash
opencode run --agent "integrate: JSON-LD, FAQ schema, structured data" --file aieo/format-schema.md
```

## Formatting Rules
- Clear H2/H3 hierarchy
- Bullet points for scannability
- Numbered steps for processes
- Definition boxes for terms
- Comparison tables
- FAQ sections
- TL;DR summaries

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Structure Clarity | 30% |
| Scannability | 25% |
| Schema Integration | 25% |
| LLM Parseability | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/content/*.md
RL_SCORE: 96
PAGES_OPTIMIZED: 34
```
