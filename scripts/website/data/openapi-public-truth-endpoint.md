# OpenAPI Public Truth Endpoint

## Purpose
Create machine-readable API endpoints that serve canonical entity data for LLM ingestion.

## Step-by-Step

### Step 1: Endpoint Design
```bash
opencode run --agent "design endpoints: /api/v1/entity/{type}, /api/v1/company, /api/v1/products" --file website/api-design.md
```

### Step 2: OpenAPI Spec
```bash
opencode run --agent "generate OpenAPI 3.0 spec with all endpoints" --file website/openapi.yaml
```

### Step 3: Implementation
```bash
opencode run --agent "implement endpoints: serve JSON, handle CORS, cache responses" --file website/api-implementation.md
```

## Endpoints
| Path | Purpose |
|------|---------|
| `GET /api/v1/company` | Company entity data |
| `GET /api/v1/products` | Product catalog |
| `GET /api/v1/entity/{type}/{id}` | Generic entity lookup |
| `GET /api/v1/faq` | FAQ data with schema |
| `GET /api/v1/openapi.json` | OpenAPI spec |

## Response Format
```json
{
  "entity": {
    "name": "Company Name",
    "description": "...",
    "url": "https://example.com",
    "sameAs": [...]
  },
  "schemaOrg": { ... },
  "lastUpdated": "2026-02-22T18:00:00Z"
}
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Endpoint Completeness | 25% |
| Data Accuracy | 25% |
| OpenAPI Validity | 20% |
| LLM Accessibility | 15% |
| Performance | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - api/routes/public.js
  - api/openapi.yaml
  - website/public/openapi.json
RL_SCORE: 96
ENDPOINTS_LIVE: 5/5
```
