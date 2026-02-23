---
skill_name: web-to-tools-generator
version: 1.0.0
required_tools: [hyperbrowser-sdk, node]
input_schema:
  url: string
  element_types: array
output_schema:
  tools_count: number
  tools_generated: array
  selector_validation: object
  output_path: string
  confidence: number
side_effects: [browser_session, file_generation]
minimal_self_test_command: scripts/browser/web-to-agent-tools-generator.md
---

# Skill: Web-to-Tools Generator

## Purpose
Generate TypeScript functions for interacting with any website. Creates agent tools from DOM analysis.

## Patterns Applied
- PATTERN-003: Contextual Analysis
- PATTERN-005: JSON Response

## Input Schema

```yaml
url: "https://example.com"
element_types: ["button", "input", "form", "nav"]
```

## Output Schema

```json
{
  "analysis": "Generated 12 tools, 10 valid selectors",
  "structured_output": {
    "tools_count": 12,
    "tools_generated": ["search", "login", "submit_form"],
    "selector_validation": {
      "valid": 10,
      "invalid": 2
    },
    "output_path": "outputs/browser/.../generated/tools.ts"
  },
  "confidence": 0.91
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Tool accuracy | 35% |
| Selector validity | 35% |
| Code quality | 20% |
| Token efficiency | 10% |
