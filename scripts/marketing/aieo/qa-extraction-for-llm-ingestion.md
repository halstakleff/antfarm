# Q&A Extraction for LLM Ingestion

## Purpose
Extract Q&A pairs from content for LLM training data.

## Step-by-Step

### Step 1: Content Scan
```bash
opencode run --agent "scan content: identify questions, extract answers" --file aieo/qa-extract.md
```

### Step 2: Q&A Formatting
```bash
opencode run --agent "format: Question → Answer pairs" --file aieo/qa-format.md
```

### Step 3: Publication
```bash
opencode run --agent "publish: /qa.json, FAQ schema integration" --file aieo/qa-publish.md
```

## Output Format
```json
{
  "questions": [
    {
      "question": "What is X?",
      "answer": "X is...",
      "category": "Product",
      "source": "/page"
    }
  ]
}
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Coverage | 30% |
| Answer Quality | 30% |
| Format | 20% |
| Schema | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/data/qa.json
  - website/sections/FAQ.tsx
RL_SCORE: 95
QA_PAIRS: 128
```
