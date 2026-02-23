---
skill_name: scrape-to-openapi-generator
version: 1.0.0
required_tools: [hyperbrowser-sdk, swagger-cli, node]
input_schema:
  url: string
  selectors: object
  api_name: string
output_schema:
  openapi_path: string
  client_path: string
  schema_valid: boolean
  endpoints: array
  confidence: number
side_effects: [browser_session, file_generation, schema_validation]
minimal_self_test_command: scripts/browser/scrape-to-api-blueprint.md
---

# Skill: Scrape-to-OpenAPI Generator

## Purpose
Convert webpage data structures into OpenAPI specs + TypeScript clients. Reverse engineering for APIs.

## Patterns Applied
- PATTERN-003: Contextual Analysis
- PATTERN-005: JSON Response

## Input Schema

```yaml
url: "https://example.com/api-docs"
selectors:
  results: ".result-item"
  pagination: ".pagination"
api_name: "example-api"
```

## Output Schema

```json
{
  "analysis": "Generated OpenAPI spec with 3 endpoints",
  "structured_output": {
    "openapi_path": "outputs/browser/.../openapi.yaml",
    "client_path": "outputs/browser/.../client.ts",
    "schema_valid": true,
    "endpoints": ["GET /scraped-data", "POST /search"]
  },
  "confidence": 0.92
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Schema accuracy | 35% |
| OpenAPI validity | 25% |
| Client usability | 25% |
| Token efficiency | 15% |
