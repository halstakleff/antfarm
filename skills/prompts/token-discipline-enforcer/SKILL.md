---
skill_name: token-discipline-enforcer
version: 1.0.0
required_tools: [opencode CLI, token counter, compressor]
input_schema:
  raw_prompt: string
  max_tokens: number
  compression_strategy: string
  pattern_id: string
output_schema:
  compressed_prompt: string
  original_tokens: number
  compressed_tokens: number
  compression_ratio: number
  references_added: array
  removed_elements: array
  confidence: number
token_budget_saved: number
  rl_score: number
side_effects: [compresses prompts, logs savings, validates efficiency]
minimal_self_test_command: opencode run --agent "test token discipline" --dry-run
---

# Token Discipline Enforcer

## Purpose
Enforce token efficiency by compressing prompts.

## Strategies

### Replace Repetition with References
❌ Before:
```
"Always validate inputs. Always check schemas. Always log outputs."
```
(15 tokens × 3 = 45 tokens)

✅ After:
```
"Follow RULE-001: {{rule_001}}"
```
(5 tokens, reference to rule library)

### Summarize Intermediate Reasoning
❌ Before:
```
"I thought about the problem for a while and considered several approaches..."
```

✅ After:
```
"Analysis: [See REASONING-001]"
```

### Group Constraints
❌ Before:
```
"Don't do X. Don't do Y. Don't do Z."
```

✅ After:
```
"Constraints: {{constraints_xyz}}"
```

## Input Schema

```yaml
raw_prompt: "Long verbose instructions..."
max_tokens: 4000
compression_strategy: "reference_replacement"
pattern_id: "PATTERN-TBD"
```

## Output Schema

```json
{
  "compressed_prompt": "Compressed version...",
  "original_tokens": 4500,
  "compressed_tokens": 3200,
  "compression_ratio": 0.71,
  "references_added": ["rule_001", "constraint_xyz"],
  "removed_elements": ["filler_words", "redundant_phrases"],
  "confidence": 0.94,
  "token_budget_saved": 1300
}
```

## Compression Tactics

| Tactic | Savings |
|--------|---------|
| Reference replacement | 30-40% |
| Summarization | 20-30% |
| Abbreviation | 10-15% |
| Whitespace removal | 5-10% |

## Enforcement Rules

1. **Over budget**: Reject without compression
2. **90%+ threshold**: Warn
3. **95%+ threshold**: Accept
4. **Under budget**: Log efficiency gain

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Compression Ratio | 40% |
| Meaning Retention | 30% |
| Schema Compliance | 20% |
| Budget Adherence | 10% |

**Threshold: ≥95**

## Usage

```bash
opencode run --agent "token-discipline-enforcer" \
  --input raw_prompt="..." \
  --max_tokens=4000
```
