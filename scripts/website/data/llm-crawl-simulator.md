# LLM Crawl Simulator

## Purpose
Simulate how LLMs crawl and parse website content.

## Step-by-Step

### Step 1: Crawl Analysis
```bash
opencode run --agent "simulate LLM crawl: fetch pages, extract entities, parse structure" --file website/llm-crawl-simulate.md
```

### Step 2: Extraction Report
```bash
opencode run --agent "report: what entities found, citations extracted, confidence scores" --file website/llm-extraction-report.md
```

### Step 3: Optimization
```bash
opencode run --agent "optimize: improve entity visibility, schema clarity, content structure" --file website/llm-optimization.md
```

## Simulation Output
```json
{
  "pages_crawled": 42,
  "entities_extracted": 156,
  "citations_found": [
    {"entity": "Company Name", "context": "...", "confidence": 0.94}
  ],
  "issues": [
    "Missing entity definitions on /about",
    "Schema not parsing on /pricing"
  ]
}
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Crawl Coverage | 25% |
| Entity Extraction | 25% |
| Accuracy | 25% |
| Issue Detection | 15% |
| Recommendations | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/data/llm-simulation.json
  - website/optimization-report.md
RL_SCORE: 95
ENTITIES_EXTRACTED: 156
CITATIONS: 42
```
