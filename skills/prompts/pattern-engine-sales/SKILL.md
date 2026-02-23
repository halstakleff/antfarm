---
skill_name: pattern-engine-sales
version: 1.0.0
required_tools: [opencode CLI, tone analyzer, schema validator]
input_schema:
  persona: string
  pain_point: string
  offer: string
  channel: string
  sequence_length: number
  pattern_id: string
output_schema:
  emails: array
  subjects: array
  ctas: array
  follow_ups: array
  tone_analysis: object
  confidence: number
  tokens_used: number
side_effects: [generates emails, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-sales" --dry-run
---

# Pattern Engine: Sales

## Purpose
Generate sales email sequences using controlled pattern abstractions.

## Patterns Applied
- PATTERN-005: Structured JSON Response
- PATTERN-007: Variable Slot Templating
- PATTERN-008: Constrained Output Generation
- PATTERN-010: Iterative Refinement Loop

## Input Schema

```yaml
persona: "CTO"
pain_point: "Slow deployment cycles"
offer: "CI/CD automation"
channel: "email"
sequence_length: 4
pattern_id: "sales-email"
```

## Output Schema

```json
{
  "analysis": "4-touch sequence personalized for CTO pain",
  "structured_output": {
    "emails": [{"body": "..."}],
    "subjects": ["Subject 1", ...],
    "ctas": ["Book a demo", ...],
    "tone_analysis": {"confidence": 0.92}
  }
}
```

## Validation Rules
- Tone appropriate
- Personalization present
- CTAs clear
- Confidence ≥0.93

## Usage

```bash
opencode run --agent "pattern-engine-sales" --pattern pattern-engine-sales
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Personalization | 30% |
| CTA Clarity | 25% |
| Tone Fit | 15% |
| Token Efficiency | 5% |
| Schema | 10% |

**Threshold: ≥95**
