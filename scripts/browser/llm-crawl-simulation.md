---
script_id: browser-llm-crawl-simulation
version: 1.0.0
sacred_docs: [PROJECT_KB.md, ENTITY_MAP.md]
framework_refs: [framework/browser-agent-layer.md]
---

# Script: LLM Crawl Simulation

## Title
LLM Crawl Simulation — Compare Raw HTML vs Rendered DOM

## Purpose
Simulate how LLMs crawl a webpage by comparing raw HTML (static) vs JavaScript-rendered DOM. Detect content gaps that hurt AIEO/LLM visibility.

## When to Run
- Before AIEO audit
- After website updates
- When diagnosing indexability issues
- SEO/AIEO Phase 1

## Prerequisites
- URLs to test
- Selector specification
- HYPERBROWSER_API_KEY set

## Inputs

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| url | string | Yes | Target URL to simulate |
| selectors | array | Yes | Elements to compare (e.g., ["h1", ".content"]) |
| output_dir | string | No | Output directory (default: outputs/browser/<date>/) |

## Outputs

| File | Path | Description |
|------|------|-------------|
| llm_crawl_report.json | outputs/browser/<date>/<url_slug>/llm_crawl_report.json | Full comparison report |
| raw_html.html | outputs/browser/<date>/<url_slug>/evidence/raw.html | Raw HTML snapshot |
| rendered_html.html | outputs/browser/<date>/<url_slug>/evidence/rendered.html | Rendered DOM snapshot |

## Step-by-Step Execution

### Step 0: Validation (Severities S0-S3)
```bash
# S0: Fail if HYPERBROWSER_API_KEY missing
if [ -z "$HYPERBROWSER_API_KEY" ]; then
  echo '{"error":"HYPERBROWSER_API_KEY required"}' >2
  exit 1
fi

# S1: Validate URL format
if ! echo "$url" | grep -qE '^https?://'; then
  echo '{"error":"Invalid URL format"}' >2
  exit 1
fi
```

### Step 1: Fetch Raw HTML (Static)
```bash
# Fetch raw HTML without rendering
curl -sL "$url" > outputs/browser/$date/$slug/evidence/raw.html
raw_html=$(cat outputs/browser/$date/$slug/evidence/raw.html)

echo "[STATUS] Raw HTML fetched: ${#raw_html} chars"
```

### Step 2: Fetch Rendered HTML (JavaScript)
```bash
# Use Hyperbrowser for rendered DOM
node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs render \
  "$url" \
  --wait=3000 \
  --full-html > outputs/browser/$date/$slug/evidence/rendered.json

rendered_html=$(jq -r '.html' outputs/browser/$date/$slug/evidence/rendered.json)
echo "$rendered_html" > outputs/browser/$date/$slug/evidence/rendered.html

echo "[STATUS] Rendered HTML fetched: ${#rendered_html} chars"
```

### Step 3: Extract and Compare
```bash
#!/bin/bash
# Extract content from both sources and compare

opencode run --agent "extraction-comparator" \
  --file task.yaml \
  --input raw_path="outputs/browser/$date/$slug/evidence/raw.html" \
  --input rendered_path="outputs/browser/$date/$slug/evidence/rendered.html" \
  --input selectors='["h1","h2","main",".content","[data-testid]"]'
```

### Step 4: Generate Report
```bash
# Create JSON comparison report
cat > outputs/browser/$date/$slug/llm_crawl_report.json << 'EOF'
{
  "url": "$url",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "comparison": {
    "raw_html_size": ${#raw_html},
    "rendered_html_size": ${#rendered_html},
    "js_dependency_percent": $((100 * (${#rendered_html} - ${#raw_html}) / ${#raw_html})),
    "critical_elements": {
      "h1": {
        "raw_present": true,
        "rendered_present": true,
        "match": true
      },
      "main_content": {
        "raw_present": false,
        "rendered_present": true,
        "risk": "HIGH"
      }
    }
  },
  "recommendations": [
    "Add static h1 fallback",
    "Consider SSR for main content"
  ]
}
EOF
```

### Step 5: Update Sacred Documents
```bash
# Update PROJECT_KB.md with findings
echo "
## $(date) - LLM Crawl Simulation: $url
- JS dependency: X%
- Missing in raw HTML: [elements]
- Risk level: HIGH/MEDIUM/LOW
" |>> PROJECT_KB.md
```

## Ralph Loop Wrapper

```yaml
# PROJECT_KB.md entry
task_id: browser-llm-crawl-$url
trigger: seo/aieo audit
steps:
  - fetch_raw
  - fetch_rendered
  - compare
  - report
severity_thresholds:
  S0: HYPERBROWSER_API_KEY missing → STOP
  S1: URL invalid → STOP
  S2: <50% content in raw HTML → WARN
  S3: Critical elements JS-only → FLAG
rl_threshold: 95
current_score: TBD
```

## RL Scoring Rubric

| Criterion | Weight | Target |
|-----------|--------|--------|
| Comparison accuracy | 25% | >= 95% |
| JS detection coverage | 25% | >= 95% |
| Report completeness | 20% | JSON valid |
| Evidence captured | 15% | Both HTMLs saved |
| Token efficiency | 10% | < 5000 tokens |
| Schema compliance | 5% | Valid JSON |
| **TOTAL** | **100%** | **>= 95** |

**Enforcement**: If RL < 95, trigger refinement loop.

## Severity Enforcement (S0–S3)

- **S0 (Critical)**: Missing API key → Exit 1
- **S1 (High)**: URL invalid → Exit 1
- **S2 (Medium)**: 50%+ JS dependency → Warn, continue
- **S3 (Low)**: Minor elements JS-only → Log only

## Sacred Documents Updates

- **PROJECT_KB.md**: Log crawl results, JS dependency %
- **ENTITY_MAP.md**: Update if entity data affected by rendering

## Verification Commands

```bash
# Verify outputs exist
ls outputs/browser/$date/$slug/llm_crawl_report.json
ls outputs/browser/$date/$slug/evidence/raw.html
ls outputs/browser/$date/$slug/evidence/rendered.html

# Validate JSON
jq empty outputs/browser/$date/$slug/llm_crawl_report.json

# Verify HTML sizes
echo "Raw: $(wc -c < outputs/browser/$date/$slug/evidence/raw.html)"
echo "Rendered: $(wc -c < outputs/browser/$date/$slug/evidence/rendered.html)"
```

## Rollback / Undo

```bash
# Remove outputs
rm -rf outputs/browser/$date/$slug/

# Revert PROJECT_KB.md entry
git checkout PROJECT_KB.md
```

## Error Handling

| Error | Action | Exit Code |
|-------|--------|-----------|
| API_KEY missing | Log, exit | 1 |
| URL invalid | Log, exit | 1 |
| Network failure | Retry 3x, then exit | 2 |
| Timeout | Log partial results | 0 |

## Status Output Format

```json
{
  "STATUS": "COMPLETE|PARTIAL|FAILED",
  "FILES_MODIFIED": [
    "outputs/browser/2026-02-22/example-com/llm_crawl_report.json",
    "outputs/browser/2026-02-22/example-com/evidence/raw.html",
    "outputs/browser/2026-02-22/example-com/evidence/rendered.html"
  ],
  "COMMANDS_RUN": [
    "curl -sL $url",
    "node run.mjs render $url",
    "jq analysis"
  ],
  "TEST_RESULTS": {
    "raw_html_size": 15234,
    "rendered_html_size": 45231,
    "js_dependency_percent": 197
  },
  "RL_SCORE": 96,
  "NEXT_STEPS": [
    "Review recommendations in report",
    "Address HIGH risk items"
  ]
}
```
