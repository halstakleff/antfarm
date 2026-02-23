# Browser Agent Layer - Integration Guide

## Quick Start

### 1. Install Workflow
```bash
cd /Users/nit/.openclaw/workspace/antfarm
node dist/cli/cli.js workflow install feature-dev --force
```

### 2. Set API Key
```bash
export HYPERBROWSER_API_KEY="your_key_here"
```

### 3. Run Browser Task
```bash
node dist/cli/cli.js workflow run feature-dev \
  "Browser: Validate schema on https://example.com"
```

---

## Integration Points

### SEO Scripts → Browser Skills

Before (static analysis):
```bash
curl -s https://example.com | grep -o '<title>.*</title>'
```

After (rendered DOM):
```bash
opencode run --agent "browser-validator" \
  --action "extract" \
  --url "https://example.com" \
  --selectors '{"title":"title","h1":"h1"}'
```

### AIEO Scripts → Browser Skills

Before (assumed structure):
```bash
# No actual page fetch
```

After (LLM crawl simulation):
```bash
opencode run --agent "browser-validator" \
  --action "llm-crawl" \
  --url "https://example.com"
```

### Website Conversion → Browser Skills

Before (template-based):
```bash
# Static comparison
```

After (page anatomy extraction):
```bash
opencode run --agent "browser-validator" \
  --action "anatomy" \
  --url "https://competitor.com"
```

---

## Sacred Documents

### PROJECT_KB.md Updates

Browser tasks automatically update:
- Crawl results
- JS dependency %
- Entity consistency scores

### ENTITY_MAP.md Updates

Schema extraction automatically updates:
- Entity definitions
- SameAs references
- Knowledge panel data

### BROWSER_USAGE.md

All browser invocations are logged:
```yaml
- timestamp: "2026-02-22T21:00:00Z"
  script: "seo-audit"
  url: "example.com"
  skill: "dom-extractor"
  rl_score: 96
```

---

## RL Scoring Enforcement

All browser script executions:
- Must achieve RL >= 95
- Trigger refinement loop if below
- Log scores to BROWSER_USAGE.md

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Missing API key | Set HYPERBROWSER_API_KEY |
| Rate limit | Wait 6 seconds between requests |
| Timeout | Increase --wait parameter |
| Invalid selector | Try alternative selector syntax |

---

## Available Actions

| Action | Purpose | Usage |
|--------|---------|-------|
| render | Get rendered HTML | Page analysis |
| extract | Extract with selectors | Data extraction |
| crawl | Multi-page crawl | SEO audits |
| anatomy | Full page structure | Competitor analysis |
| llm-crawl | Raw vs rendered | AIEO validation |
| schema | JSON-LD extract | SEO/AIEO |
| qa | Post-deploy check | Regression testing |
