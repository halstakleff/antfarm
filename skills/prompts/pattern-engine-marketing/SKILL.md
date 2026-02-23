---
skill_name: pattern-engine-marketing
version: 1.0.0
required_tools: [opencode CLI, marketing analyzer, schema validator]
input_schema:
  campaign_type: string
  target_audience: string
  channel: string
  budget: number
  goals: array
  pattern_id: string
output_schema:
  campaign_structure: object
  messaging_framework: object
  distribution_plan: array
  metrics: object
  recommendations: array
  confidence: number
  tokens_used: number
side_effects: [generates campaigns, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-marketing" --dry-run
---

# Pattern Engine: Marketing

## Purpose
Generate marketing campaigns using controlled pattern abstractions.

## Patterns Applied
- PATTERN-005: Structured JSON Response
- PATTERN-007: Variable Slot Templating
- PATTERN-008: Constrained Output Generation
- PATTERN-010: Iterative Refinement Loop

## Input Schema

```yaml
campaign_type: "product_launch"
target_audience: "Marketing Directors"
channel: "email"
budget: 10000
goals: ["signups", "demos"]
pattern_id: "marketing-campaign"
```

## Output Schema

```json
{
  "analysis": "Campaign structured for 3-touch sequence",
  "structured_output": {
    "campaign_structure": {"emails": [...]},
    "messaging_framework": {"voice": "...", "tone": "..."},
    "distribution_plan": [{"day": 1, ...}],
    "metrics": {"target_roas": 4.0}
  }
}
```

## Validation Rules
- Budget respected
- Goals actionable
- Metrics trackable
- Confidence ≥0.91

## Usage

```bash
opencode run --agent "pattern-engine-marketing" --pattern pattern-engine-marketing
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Messaging Quality | 30% |
| Channel Fit | 20% |
| Metric Clarity | 20% |
| Token Efficiency | 10% |
| Schema | 5% |

**Threshold: ≥95**
