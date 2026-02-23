---
skill_name: dom-extractor
version: 1.0.0
required_tools: [hyperbrowser-sdk, pup, jq]
input_schema:
  url: string
  selectors: object
  wait_for: string
output_schema:
  extracted: object
  url: string
  selectors_matched: number
  selectors_failed: array
  evidence_paths: array
  confidence: number
side_effects: [browser_session, file_output]
minimal_self_test_command: node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs extract https://example.com '{"title":"h1"}'
---

# Skill: DOM Extractor

## Purpose
Extract structured data from webpages using CSS selectors. Returns text, HTML, and metadata.

## Patterns Applied
- PATTERN-002: Tool Invocation
- PATTERN-003: Contextual Analysis
- PATTERN-005: JSON Response

## Input Schema

```yaml
url: "https://example.com"
selectors:
  title: "h1"
  price: ".price"
  description: "meta[name='description']"
wait_for: "networkidle"
```

## Output Schema

```json
{
  "analysis": "Extracted 3 of 3 selectors",
  "structured_output": {
    "extracted": {
      "title": { "text": "Product Name", "html": "<h1>..." },
      "price": { "text": "$99", "selector": ".price" }
    },
    "selectors_matched": 3,
    "selectors_failed": [],
    "evidence_paths": ["outputs/browser/.../evidence/raw.html"]
  },
  "confidence": 0.96
}
```

## Usage

```bash
opencode run --agent "dom-extractor" \
  --url "https://example.com" \
  --selectors '{"h1":"h1","price":".price"}'
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Selector match rate | 40% |
| Data accuracy | 30% |
| Evidence captured | 20% |
| Token efficiency | 10% |
