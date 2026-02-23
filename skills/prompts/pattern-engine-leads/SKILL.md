---
skill_name: pattern-engine-leads
version: 1.0.0
required_tools: [opencode CLI, apollo enrichment, schema validator]
input_schema:
  persona: string
  company_criteria: object
  enrichment_level: string
  max_results: number
  pattern_id: string
output_schema:
  prospects: array
  enriched_data: array
  sources: array
  confidence_scores: array
  recommendations: array
  confidence: number
  tokens_used: number
side_effects: [enriches contacts, validates schema, logs invocation, handles PII]
minimal_self_test_command: opencode run --agent "test pattern-engine-leads" --dry-run
---

# Pattern Engine: Leads

## Purpose
Enrich lead data using controlled pattern abstractions.

## Patterns Applied
- PATTERN-002: Tool Invocation with Validation
- PATTERN-005: Structured JSON Response
- PATTERN-009: Hierarchical Instruction Following

## Input Schema

```yaml
persona: "CTO"
company_criteria:
  size: "50-500"
  industry: "SaaS"
enrichment_level: "full"
max_results: 100
pattern_id: "lead-enrichment"
```

## Output Schema

```json
{
  "analysis": "100 prospects enriched, 87 emails found",
  "structured_output": {
    "prospects": [{"name": "...", "email": "..."}],
    "enriched_data": [{"company": "...", "tech_stack": [...]}],
    "confidence_scores": [0.95, 0.87, ...]
  }
}
```

## Validation Rules
- PII sanitized
- Confidence tracked
- Sources cited
- Confidence ≥0.90

## Usage

```bash
opencode run --agent "pattern-engine-leads" --pattern pattern-engine-leads
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Accuracy | 30% |
| Coverage | 25% |
| Data Quality | 15% |
| Token Efficiency | 10% |
| Schema | 5% |

**Threshold: ≥95**
