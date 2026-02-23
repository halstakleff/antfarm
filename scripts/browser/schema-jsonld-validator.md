---
script_id: browser-schema-jsonld-validator
version: 1.0.0
sacred_docs: [PROJECT_KB.md, ENTITY_MAP.md]
framework_refs: [framework/browser-agent-layer.md, framework/browser-agent-security.md]
---

# Script: Schema JSON-LD Validator

## Title
Schema JSON-LD Validator — Extract and Validate Structured Data

## Purpose
Extract all JSON-LD blocks from a webpage and validate presence of required schema types (Organization, LocalBusiness, Product, FAQ, etc.).

## When to Run
- SEO audit Phase 2
- AIEO validation
- Pre-launch checklist
- Post-update validation

## Prerequisites
- HYPERBROWSER_API_KEY set
- Target URL accessible

## Inputs

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| url | string | Yes | Target URL |
| required_types | array | No | Schema types to validate (default: all) |
| output_dir | string | No | Output directory |

## Outputs

| File | Path | Description |
|------|------|-------------|
| schema_report.json | outputs/browser/<date>/<url_slug>/schema_report.json | Full validation report |
| entity_consistency_score.json | outputs/browser/<date>/<url_slug>/entity_consistency_score.json | Consistency metrics |
| evidence/schemas.jsonld | outputs/browser/<date>/<url_slug>/evidence/schemas.jsonld | Raw extracted JSON-LD |

## Step-by-Step Execution

### Step 0: Validation
```bash
# S0: API key check
if [ -z "$HYPERBROWSER_API_KEY" ]; then
  echo '{"error":"HYPERBROWSER_API_KEY required"}' >2
  exit 1
fi

# Validate URL
if ! echo "$url" | grep -qE '^https?://'; then
  echo '{"error":"Invalid URL"}' >2
  exit 1
fi
```

### Step 1: Extract JSON-LD
```bash
# Use Hyperbrowser to get rendered page
node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs render \
  "$url" \
  --wait=2000 \
  --full-html > /tmp/page.json

html=$(jq -r '.html' /tmp/page.json)

# Extract all script[type="application/ld+json"] blocks
echo "$html" | grep -oP '<script type="application/ld+json"[^\u003e]*\u003e\K[^\u003c]+' > /tmp/schemas.raw
```

### Step 2: Parse and Validate (OpenCode CLI)
```bash
#!/bin/bash
# Parse and validate each JSON-LD block

opencode run --agent "schema-validator" \
  --input raw_schemas="/tmp/schemas.raw" \
  --input required_types='["Organization","WebPage","FAQPage"]' \
  --output schema_report.json

# Validate output exists
if [ ! -s schema_report.json ]; then
  echo "ERROR: No schemas found or validation failed"
  exit 1
fi
```

### Step 3: Score Entity Consistency
```javascript
// Check entity names match across schemas
const orgs = schemas.filter(s => s['@type'] === 'Organization');
const names = orgs.map(s => s.name);
const uniqueNames = [...new Set(names)];
const consistencyScore = uniqueNames.length === 1 ? 100 : (1 / uniqueNames.length) * 100;
```

### Step 4: Generate Reports
```json
{
  "url": "https://example.com",
  "timestamp": "2026-02-22T21:00:00Z",
  "schemas_found": 5,
  "schemas": [
    {
      "type": "Organization",
      "present": true,
      "fields_valid": {
        "name": true,
        "url": true,
        "logo": false
      }
    }
  ],
  "missing_required": ["FAQPage"],
  "entity_consistency_score": 85,
  "recommendations": [
    "Add FAQPage schema",
    "Add logo to Organization"
  ]
}
```

### Step 5: Update Sacred Documents
```bash
echo "
## $(date) - Schema Validation: $url
- Schemas found: X
- Entity consistency: Y%
- Missing: [list]
" |>> PROJECT_KB.md
```

## RL Scoring Rubric

| Criterion | Weight | Target |
|-----------|--------|--------|
| Schema extraction | 25% | 100% of JSON-LD found |
| Validation accuracy | 25% | >= 95% |
| Consistency score | 20% | JSON valid |
| Report completeness | 15% | All fields documented |
| Token efficiency | 10% | < 3000 tokens |
| Schema compliance | 5% | Valid JSON output |
| **TOTAL** | **100%** | **>= 95** |

## Severity Enforcement

- **S0**: Missing API key → Exit 1
- **S1**: No JSON-LD found → Warn
- **S2**: Missing required types → Warn
- **S3**: Entity inconsistency → Log

## Status Output Format

```json
{
  "STATUS": "COMPLETE",
  "FILES_MODIFIED": [
    "outputs/browser/2026-02-22/example-com/schema_report.json"
  ],
  "COMMANDS_RUN": [
    "node run.mjs render",
    "grep extract",
    "jq validate"
  ],
  "TEST_RESULTS": {
    "schemas_found": 5,
    "entity_consistency_score": 85
  },
  "RL_SCORE": 96,
  "NEXT_STEPS": [
    "Add missing FAQPage schema"
  ]
}
```
