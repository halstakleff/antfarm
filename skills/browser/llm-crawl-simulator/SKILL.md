---
skill_name: llm-crawl-simulator
version: 1.0.0
required_tools: [hyperbrowser-sdk, curl]
input_schema:
  url: string
  selectors: array
output_schema:
  raw_coverage: number
  rendered_coverage: number
  js_dependency_percent: number
  critical_missing: array
  recommendations: array
  confidence: number
side_effects: [browser_session, curl_request, file_output]
minimal_self_test_command: scripts/browser/llm-crawl-simulation.md
---

# Skill: LLM Crawl Simulator

## Purpose
Simulate how LLMs crawl by comparing raw HTML vs rendered DOM. Identifies content gaps for AIEO.

## Patterns Applied
- PATTERN-004: Multi-Step Chain
- PATTERN-005: JSON Response
- PATTERN-010: Iterative Refinement

## Input Schema

```yaml
url: "https://example.com"
selectors: ["h1", "h2", "main", ".content", "[data-testid]"]
```

## Output Schema

```json
{
  "analysis": "50% content JS-dependent",
  "structured_output": {
    "raw_coverage": 45,
    "rendered_coverage": 95,
    "js_dependency_percent": 53,
    "critical_missing": ["main content", "FAQ section"],
    "recommendations": ["Add static h1", "SSR for FAQs"]
  },
  "confidence": 0.94
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Detection accuracy | 35% |
| Comparison validity | 25% |
| Coverage scoring | 25% |
| Schema validity | 10% |
| Token efficiency | 5% |
