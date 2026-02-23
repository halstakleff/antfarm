---
script_id: browser-scrape-to-api-blueprint
version: 1.0.0
sacred_docs: [PROJECT_KB.md]
framework_refs: [framework/browser-agent-layer.md]
---

# Script: Scrape-to-API Blueprint

## Title
Scrape-to-API — Convert Web Extraction to REST Endpoints

## Purpose
Convert a webpage's data structure into OpenAPI specifications, TypeScript client stubs, and example curl commands.

## When to Run
- API reverse engineering
- Data integration projects
- Headless CMS extraction
- Competitor data modeling

## Prerequisites
- Target URL with structured data
- Extraction spec (selectors)
- HYPERBROWSER_API_KEY

## Inputs

| Field | Type | Required |
|-------|------|----------|
| url | string | Yes |
| selectors | object | Yes |
| output_name | string | No (default: site-api) |

## Outputs

| File | Path | Description |
|------|------|-------------|
| openapi.yaml | outputs/browser/<date>/<name>/openapi.yaml | OpenAPI spec |
| client.ts | outputs/browser/<date>/<name>/client.ts | Typed client |
| example.curl | outputs/browser/<date>/<name>/example.curl | Sample requests |
| verification_results.json | outputs/browser/<date>/<name>/verification_results.json | API tests |

## Step-by-Step Execution

### Step 1: Extract Structure
```bash
node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs extract \
  "$url" \
  '{"results":".result-item","pagination":".pagination"}' \
  > /tmp/data.json
```

### Step 2: Infer Schema
```javascript
const sample = data[0];
const schema = {
  type: 'object',
  properties: Object.entries(sample).map(([k, v]) => ({
    name: k,
    type: typeof v,
    required: true
  }))
};
```

### Step 3: Generate OpenAPI
```yaml
# openapi.yaml
openapi: 3.0.0
paths:
  /scrape:
    get:
      summary: Extract from $url
      responses:
        '200':
          content:
            application/json:
              schema: { $ref: '#/components/schemas/ExtractedData' }
```

### Step 4: Generate Client
```typescript
// client.ts
export class SiteApiClient {
  async scrape(): Promise<ExtractedData[]> {
    const res = await fetch('/scrape');
    return res.json();
  }
}
```

### Step 5: Verification
```bash
# Test the API contract
curl -X GET http://localhost:3000/scrape |> verification_results.json

# Validate against OpenAPI spec
swagger-cli validate openapi.yaml
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Schema accuracy | 30% |
| OpenAPI validity | 25% |
| Client usability | 20% |
| Verification pass | 15% |
| Token efficiency | 10% |

## Status Output

```json
{
  "STATUS": "COMPLETE",
  "FILES_MODIFIED": [
    "outputs/browser/2026-02-22/site-api/openapi.yaml",
    "outputs/browser/2026-02-22/site-api/client.ts"
  ],
  "TEST_RESULTS": {
    "schema_fields": 12,
    "verification_passed": true
  },
  "RL_SCORE": 96,
  "NEXT_STEPS": ["Test client integration"]
}
```
