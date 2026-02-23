---
skill_name: pattern-engine-aieo
version: 1.0.0
required_tools: [opencode CLI, entity validator, schema validator]
input_schema:
  entity: string
  entity_type: string
  citations: array
  knowledge_base: object
  pattern_id: string
output_schema:
  consistency_score: number
  visibility_score: number
  entity_map: object
  citation_gaps: array
  recommendations: array
  confidence: number
  tokens_used: number
side_effects: [audits entity consistency, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-aieo" --dry-run
---

# Pattern Engine: AIEO

## Purpose
Optimize for LLM visibility using controlled pattern abstractions.

## Patterns Applied
- PATTERN-003: Contextual File Analysis
- PATTERN-005: Structured JSON Response
- PATTERN-006: Chain-of-Thought Containment

## Input Schema

```yaml
entity: "Acme Corp"
entity_type: "Organization"
citations: ["crunchbase.com", "linkedin.com"]
knowledge_base: {}
pattern_id: "aieo-audit"
```

## Output Schema

```json
{
  "analysis": "Entity consistency 98%, visibility 85%",
  "structured_output": {
    "consistency_score": 0.98,
    "visibility_score": 0.85,
    "entity_map": {"name": "Acme Corp", ...},
    "citation_gaps": ["wikipedia"]
  }
}
```

## Validation Rules
- Consistency 100% required
- Visibility tracked
- Scores 0-1
- Confidence ≥0.92

## Usage

```bash
opencode run --agent "pattern-engine-aieo" --pattern pattern-engine-aieo
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Consistency | 35% |
| Visibility | 30% |
| Citation Quality | 10% |
| Token Efficiency | 5% |
| Schema | 5% |

**Threshold: ≥95**
