---
skill_name: pattern-engine-analytics
version: 1.0.0
required_tools: [opencode CLI, data analyzer, schema validator]
input_schema:
  metrics: array
  timeframe: string
  dimensions: array
  filters: object
  pattern_id: string
output_schema:
  summary: string
  insights: array
  recommendations: array
  visualizations: array
  anomalies: array
  confidence: number
  tokens_used: number
side_effects: [analyzes data, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-analytics" --dry-run
---

# Pattern Engine: Analytics

## Purpose
Generate analytics reports using controlled pattern abstractions.

## Patterns Applied
- PATTERN-003: Contextual File Analysis
- PATTERN-005: Structured JSON Response
- PATTERN-006: Chain-of-Thought Containment

## Input Schema

```yaml
metrics: ["traffic", "conversions", "revenue"]
timeframe: "last_30_days"
dimensions: ["channel", "campaign"]
filters: {"channel": "organic"}
pattern_id: "analytics-report"
```

## Output Schema

```json
{
  "analysis": "Traffic up 23%, conversions flat",
  "structured_output": {
    "summary": "Organic traffic growing",
    "insights": [{"type": "opportunity", ...}],
    "recommendations": [{"priority": "high", ...}],
    "anomalies": []
  }
}
```

## Validation Rules
- Data integrity checked
- Calculations verified
- Sources cited
- Confidence ≥0.94

## Usage

```bash
opencode run --agent "pattern-engine-analytics" --pattern pattern-engine-analytics
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Insight Quality | 30% |
| Accuracy | 25% |
| Actionability | 15% |
| Token Efficiency | 10% |
| Schema | 5% |

**Threshold: ≥95**
