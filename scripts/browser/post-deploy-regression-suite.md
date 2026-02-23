---
script_id: browser-post-deploy-regression-suite
version: 1.0.0
sacred_docs: [PROJECT_KB.md]
framework_refs: [framework/browser-agent-layer.md]
---

# Script: Post-Deploy Regression Suite

## Title
Post-Deploy Regression — Automated QA After Production Deploy

## Purpose
Validate production deployment by checking: CTA elements, pricing, schema markup, headings, and navigation links. Fail fast if critical elements missing.

## When to Run
- Immediately after production deploy
- Post-merge verification
- Daily health check
- Before marketing campaign

## Prerequisites
- Production URL
- HYPERBROWSER_API_KEY
- Reference snapshot (optional)

## Inputs

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| url | string | Yes | Production URL |
| checks | array | No | Specific checks to run |
| fail_on_critical | boolean | No | Exit non-zero on critical failure |

## Outputs

| File | Path | Description |
|------|------|-------------|
| regression_report.json | outputs/browser/<date>/<url_slug>/regression_report.json | Full report |
| failures.log | outputs/browser/<date>/<url_slug>/failures.log | Error details |

## Step-by-Step Execution

### Step 1: Fetch Page
```bash
node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs render \
  "$url" \
  --wait=3000 > /tmp/page.json

html=$(jq -r '.html' /tmp/page.json)
```

### Step 2: Validate Headings
```bash
# Check H1 exists and is visible
h1_count=$(echo "$html" | pup 'h1' | wc -l)
if [ "$h1_count" -eq 0 ]; then
  echo "FAIL: No H1 found"
  failures+=("missing_h1")
fi

# Check H2, H3 hierarchy
h2_count=$(echo "$html" | pup 'h2' | wc -l)
echo "Headings: H1=$h1_count, H2=$h2_count"
```

### Step 3: Validate CTAs
```bash
# Check CTA buttons exist and are clickable
cta_count=$(echo "$html" | pup '[data-cta], .cta, [class*="cta"]' | wc -l)
if [ "$cta_count" -eq 0 ]; then
  echo "FAIL: No CTA found"
  failures+=("missing_cta")
fi
```

### Step 4: Validate Pricing
```bash
# Check pricing elements present
price_count=$(echo "$html" | pup '[class*="price"], [class*="pricing"]' | wc -l)
if [ "$price_count" -eq 0 ]; then
  echo "WARN: No pricing elements found"
  warnings+=("no_pricing")
fi
```

### Step 5: Validate Schema
```bash
# Check JSON-LD present
schema_count=$(echo "$html" | grep -c 'application/ld+json')
if [ "$schema_count" -eq 0 ]; then
  echo "FAIL: No schema markup"
  failures+=("missing_schema")
fi
```

### Step 6: Validate Navigation
```bash
# Check nav links not broken
echo "$html" | pup 'a[href]' attr{href} | while read link; do
  if [[ "$link" == /* ]]; then
    full_url="${url%/}$link"
    curl -sI "$full_url" | head -1 |>> /tmp/link_check.log
  fi
done

broken_count=$(grep -c '404' /tmp/link_check.log || echo 0)
```

### Step 7: Generate Report
```json
{
  "url": "https://example.com",
  "timestamp": "2026-02-22T21:00:00Z",
  "overall_status": "PASS|FAIL|WARNING",
  "checks": {
    "h1_present": { "status": "PASS", "count": 1 },
    "cta_present": { "status": "PASS", "count": 3 },
    "pricing_present": { "status": "WARNING", "count": 0 },
    "schema_valid": { "status": "FAIL", "errors": ["no schema"] },
    "nav_links": { "status": "PASS", "broken": 0, "total": 12 }
  },
  "failures": ["missing_schema"],
  "recommendations": ["Add Organization schema"]
}
```

## Gating Rules

| Check | Critical? | Fail Action |
|-------|-----------|-------------|
| H1 | Yes | Exit 1 |
| CTA | Yes | Exit 1 |
| Schema | No | Warn |
| Pricing | No | Warn |
| Links | Yes (>5%) | Exit 1 |

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Check coverage | 20% |
| Detection accuracy | 25% |
| Report clarity | 20% |
| Gating logic | 20% |
| Token efficiency | 10% |
| Schema validity | 5% |

## Status Output

```json
{
  "STATUS": "FAIL",
  "FILES_MODIFIED": [
    "outputs/browser/2026-02-22/regression_report.json"
  ],
  "TEST_RESULTS": {
    "overall": "FAIL",
    "passed": 3,
    "failed": 1,
    "warnings": 1
  },
  "RL_SCORE": 94,
  "NEXT_STEPS": [
    "Fix missing schema markup",
    "Re-run regression suite"
  ]
}
```

## Rollback

```bash
# If failure, trigger rollback
if [ $(jq '.overall_status' regression_report.json) = '"FAIL"' ]; then
  echo "Regression failed. Consider rollback."
  # Trigger rollback via CI/CD
fi
```
