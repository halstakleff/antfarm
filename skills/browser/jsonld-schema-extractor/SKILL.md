---
skill_name: jsonld-schema-extractor
version: 1.0.0
required_tools: [hyperbrowser-sdk, jq]
input_schema:
  url: string
  types: array
output_schema:
  schemas: array
  types_found: array
  types_missing: array
  entity_consistency_score: number
  validation_errors: array
  confidence: number
side_effects: [browser_session, schema_validation]
minimal_self_test_command: node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs render https://example.com --wait=2000
---

# Skill: JSON-LD Schema Extractor

## Purpose
Extract and validate JSON-LD structured data. Critical for SEO and AIEO.

## Patterns Applied
- PATTERN-003: Contextual Analysis
- PATTERN-005: JSON Response

## Input Schema

```yaml
url: "https://example.com"
types: ["Organization", "WebPage", "FAQPage"]
```

## Output Schema

```json
{
  "analysis": "Found 3 schema blocks, 1 missing type",
  "structured_output": {
    "schemas": [
      { "@type": "Organization", "name": "Acme", "valid": true }
    ],
    "types_found": ["Organization", "WebPage"],
    "types_missing": ["FAQPage"],
    "entity_consistency_score": 85,
    "validation_errors": []
  },
  "confidence": 0.95
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Extraction completeness | 30% |
| Entity consistency | 30% |
| Validation coverage | 25% |
| Schema validity | 15% |
