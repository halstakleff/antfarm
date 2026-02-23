---
skill_name: rendered-html-fetcher
version: 1.0.0
required_tools: [hyperbrowser-sdk, node]
input_schema:
  url: string
  wait_for: string
  full_html: boolean
  screenshot: boolean
output_schema:
  html: string
  title: string
  url_final: string
  load_time_ms: number
  screenshot_path: string|null
  timestamp: string
  confidence: number
side_effects: [network_request, browser_session, optional_screenshot]
minimal_self_test_command: node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs render https://example.com --wait=1000
---

# Skill: Rendered HTML Fetcher

## Purpose
Fetch JavaScript-rendered DOM, not just static HTML. Essential for modern SPA/headless sites.

## Patterns Applied
- PATTERN-002: Tool Invocation with Validation
- PATTERN-005: Structured JSON Response

## Input Schema

```yaml
url: "https://example.com"
wait_for: "networkidle"  # or "load" or selector
full_html: true
screenshot: false
```

## Output Schema

```json
{
  "analysis": "Rendered DOM fetched successfully",
  "structured_output": {
    "html": "<!DOCTYPE...>",
    "title": "Example Site",
    "url_final": "https://example.com/",
    "load_time_ms": 1245,
    "screenshot_path": null,
    "timestamp": "2026-02-22T21:00:00Z"
  },
  "confidence": 0.98
}
```

## Usage

```bash
opencode run --agent "rendered-html-fetcher" \
  --url "https://example.com" \
  --wait 3000
```

## Ralph Loop

```yaml
rl_threshold: 95
checks:
  - html_length > 0
  - title exists
  - load_time_ms < 10000
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Render success | 40% |
| HTML completeness | 30% |
| Load time | 15% |
| Schema validity | 10% |
| Token efficiency | 5% |
