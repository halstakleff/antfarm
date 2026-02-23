---
skill_name: site-crawler
version: 1.0.0
required_tools: [hyperbrowser-sdk]
input_schema:
  seed_url: string
  max_pages: number
  include: array
  exclude: array
  same_domain: boolean
output_schema:
  pages: array
  pages_crawled: number
  crawl_duration_ms: number
  errors: array
  output_dir: string
  confidence: number
side_effects: [multiple_browser_sessions, file_output]
minimal_self_test_command: node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs crawl https://example.com '{"max_pages":3}'
---

# Skill: Site Crawler

## Purpose
Multi-page website crawling with configurable rules. Foundation for SEO audits and dataset generation.

## Patterns Applied
- PATTERN-003: Contextual Analysis
- PATTERN-004: Multi-Step Chain
- PATTERN-005: JSON Response

## Input Schema

```yaml
seed_url: "https://docs.example.com"
max_pages: 50
include: ["/docs", "/guides"]
exclude: ["/admin", "/api", "?draft=true"]
same_domain: true
```

## Output Schema

```json
{
  "analysis": "Crawled 47 of 50 max pages",
  "structured_output": {
    "pages_crawled": 47,
    "pages": [
      { "url": "...", "title": "...", "html_length": 45231 }
    ],
    "crawl_duration_ms": 124_000,
    "errors": [{"url": "...", "error": "timeout"}]
  },
  "confidence": 0.94
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Completion rate | 35% |
| Rule adherence | 25% |
| Data quality | 20% |
| Error handling | 10% |
| Token efficiency | 10% |
