---
skill_name: pattern-engine-seo
version: 1.0.0
required_tools: [opencode CLI, seo analyzer, schema validator]
input_schema:
  url: string
  audit_type: string
  target_keywords: array
  competitor_urls: array
  pattern_id: string
output_schema:
  issues: array
  fixes: array
  scores:
    technical: number
    content: number
    authority: number
  recommendations: array
  confidence: number
  tokens_used: number
side_effects: [runs seo audit, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-seo" --dry-run
---

# Pattern Engine: SEO

## Purpose
Execute SEO audits using controlled pattern abstractions.

## Patterns Applied
- PATTERN-003: Contextual File Analysis
- PATTERN-005: Structured JSON Response
- PATTERN-010: Iterative Refinement Loop

## Input Schema

```yaml
url: "https://example.com"
audit_type: "full"
target_keywords: ["saas billing", "subscription management"]
competitor_urls: ["competitor1.com"]
pattern_id: "seo-audit"
```

## Output Schema

```json
{
  "analysis": "Technical issues found: 3 critical, 12 warnings",
  "structured_output": {
    "issues": [{"type": "critical", "description": "..."}],
    "fixes": [{"priority": "high", "action": "..."}],
    "scores": {"technical": 78, "content": 85, "authority": 72}
  }
}
```

## Validation Rules
- Issues categorized
- Fixes prioritized
- Scores 0-100
- Confidence ≥0.90

## Usage

```bash
opencode run --agent "pattern-engine-seo" --pattern pattern-engine-seo
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Technical Score | 30% |
| Content Score | 25% |
| Authority Score | 20% |
| Token Efficiency | 5% |
| Schema | 5% |

**Threshold: ≥95**
