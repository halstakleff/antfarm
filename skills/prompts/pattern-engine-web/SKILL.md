---
skill_name: pattern-engine-web
version: 1.0.0
required_tools: [opencode CLI, html validator, schema validator]
input_schema:
  page_type: string
  target_persona: string
  key_benefit: string
  proof_elements: array
  pattern_id: string
output_schema:
  components: array
  copy_blocks: object
  schema_markup: object
  internal_links: array
  confidence: number
  tokens_used: number
side_effects: [generates website sections, validates schema, logs usage]
minimal_self_test_command: opencode run --agent "test pattern-engine-web" --dry-run
---

# Pattern Engine: Web

## Purpose
Generate high-converting website sections using controlled patterns.

## Patterns Applied
- PATTERN-005: Structured JSON Response
- PATTERN-007: Variable Slot Templating
- PATTERN-008: Constrained Output Generation
- PATTERN-010: Iterative Refinement Loop

## Input Schema

```yaml
page_type: "landing"
target_persona: "Marketing Director"
key_benefit: "3x more leads from existing traffic"
proof_elements: ["15000 customers", "4.9/5 rating"]
pattern_id: "website-build"
```

## Output Schema

```json
{
  "analysis": "Hero section optimized for conversion",
  "structured_output": {
    "components": ["Hero", "Features", "CTA"],
    "copy_blocks": {
      "hero": {"h1": "...", "subhead": "..."}
    },
    "schema_markup": {"@type": "WebPage"},
    "internal_links": [{"to": "/pricing", "text": "See pricing"}]
  }
}
```

## Validation Rules
- HTML semantic
- Schema valid
- Copy RL score ≥95
- Confidence ≥0.95

## Usage

```bash
opencode run --agent "pattern-engine-web" --pattern pattern-engine-web
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Conversion Rate | 30% |
| SEO Score | 20% |
| Copy Quality | 25% |
| Token Efficiency | 5% |
| Schema | 5% |

**Threshold: ≥95**
