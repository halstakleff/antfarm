# Browser Agent Layer

**Version**: 1.0.0  
**Purpose**: First-class browser automation layer for SEO/AIEO/website validation

---

## What Browser Layer Does

- **DOM Extraction**: Get rendered HTML, not just raw source
- **SEO Validation**: Extract structured data, headings, links
- **AIEO Simulation**: Simulate LLM crawl behavior
- **Competitor Analysis**: Compare element-by-element
- **Post-Deploy Regression**: Automated QA after deploy

---

## Input/Output Standards (JSON-First)

### Standard Input
```json
{
  "url": "https://example.com",
  "selectors": ["h1", ".pricing", "[data-cta]"],
  "options": {
    "wait_for": "networkidle",
    "timeout_ms": 30000,
    "screenshot": false
  }
}
```

### Standard Output
```json
{
  "url": "https://example.com",
  "status": 200,
  "timestamp": "2026-02-22T21:00:00Z",
  "title": "Example Page",
  "elements": {
    "h1": {"text": "Main Heading", "selector": "h1"}
  },
  "metadata": {
    "load_time_ms": 1245,
    "js_rendered": true
  }
}
```

---

## Evidence Capture Policy

All extractions store evidence:

- **Raw HTML snippets**: `outputs/browser/<date>/<task>/evidence/`
- **JSON artifacts**: Structured extraction results
- **Screenshots**: Optional, with privacy redaction
- **Selector validation**: Proof of DOM match

**Retention**: 30 days, then auto-archived

---

## Safety Constraints

1. **No password capture**: Never extract input[type="password"] values
2. **No session persistence**: Cookies cleared after each task
3. **Domain allowlist**: Only target authorized domains
4. **Rate limiting**: Max 10 req/min per domain
5. **PII redaction**: Email/phone auto-scrubbed in outputs

---

## Output Locations

```
outputs/browser/
  └── 2026-02-22/
      └── <task-id>/
          ├── results.json
          ├── evidence/
          │   ├── raw.html
          │   └── selectors/
          └── screenshots/
              └── (if enabled)
```

---

## Integration Points

| Skill | Calls Browser For |
|-------|-------------------|
| seo-audit | DOM crawl, link extraction |
| aieo-audit | Rendered content analysis |
| competitor-analysis | Element comparison |
| regression-test | Post-deploy validation |
| dataset-generator | Multi-page crawl |

---

## Environment

Required: `HYPERBROWSER_API_KEY`  
Optional: `HYPERBROWSER_BASE_URL` (for self-hosted)
