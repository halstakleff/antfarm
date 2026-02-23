---
skill_name: page-anatomy-extractor
version: 1.0.0
required_tools: [hyperbrowser-sdk]
input_schema:
  url: string
  elements: array
output_schema:
  anatomy: object
  hierarchy: array
  interactive_elements: array
  media: array
  load_performance: object
  confidence: number
side_effects: [browser_session, file_output]
minimal_self_test_command: node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs extract https://example.com '{"h1":"h1","h2":"h2"}'
---

# Skill: Page Anatomy Extractor

## Purpose
Extract complete page anatomy: headings, structure, interactive elements, media. Used for competitor analysis and UX audits.

## Patterns Applied
- PATTERN-003: Contextual Analysis
- PATTERN-005: JSON Response

## Input Schema

```yaml
url: "https://example.com"
elements: ["h1", "h2", "h3", "nav", "cta", "form", "img", "video"]
```

## Output Schema

```json
{
  "analysis": "Extracted page anatomy: 1 h1, 3 h2s, 2 CTAs",
  "structured_output": {
    "anatomy": {
      "headings": { "h1": 1, "h2": 3, "h3": 5 },
      "navigation": { "links": 12 },
      "ctas": { "buttons": 2, "forms": 1 },
      "media": { "images": 8, "videos": 0 }
    },
    "hierarchy": ["h1", "section", "h2", "h3"],
    "interactive_elements": ["button", "input", "form"]
  },
  "confidence": 0.95
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Coverage | 30% |
| Hierarchy accuracy | 30% |
| Performance metrics | 20% |
| Token efficiency | 20% |
