---
skill_name: pattern-engine-entity
version: 1.0.0
required_tools: [opencode CLI, entity database, schema validator]
input_schema:
  entity_name: string
  entity_attributes: object
  profiles: array
  pattern_id: string
output_schema:
  entity_definition: object
  same_as: array
  knowledge_panel: object
  profiles: array
  gaps: array
  confidence: number
  tokens_used: number
side_effects: [defines entities, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-entity" --dry-run
---

# Pattern Engine: Entity

## Purpose
Manage entity definitions for knowledge graph expansion.

## Patterns Applied
- PATTERN-003: Contextual File Analysis
- PATTERN-005: Structured JSON Response
- PATTERN-009: Hierarchical Instruction Following

## Input Schema

```yaml
entity_name: "Acme Corp"
entity_attributes:
  type: "Organization"
  industry: "SaaS"
  founded: "2020"
profiles: ["crunchbase", "linkedin", "twitter"]
pattern_id: "entity-definition"
```

## Output Schema

```json
{
  "analysis": "Entity defined with 7 profiles, 2 gaps",
  "structured_output": {
    "entity_definition": {"name": "Acme Corp", ...},
    "same_as": ["https://..."],
    "profiles": [{"platform": "crunchbase", ...}],
    "gaps": ["wikipedia"]
  }
}
```

## Validation Rules
- Schema valid
- Profiles complete
- Gaps documented
- Confidence ≥0.93

## Usage

```bash
opencode run --agent "pattern-engine-entity" --pattern pattern-engine-entity
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Completeness | 35% |
| Consistency | 25% |
| Profile Coverage | 10% |
| Token Efficiency | 10% |
| Schema | 5% |

**Threshold: ≥95**
