---
skill_name: pattern-engine-code
version: 1.0.0
required_tools: [opencode CLI, schema validator]
input_schema:
  task: string
  language: string
  context_files: array
  constraints: array
  pattern_id: string
output_schema:
  code: string
  tests: array
  schema: object
  explanation: string
  confidence: number
  tokens_used: number
side_effects: [generates code, validates schema, logs invocation]
minimal_self_test_command: opencode run --agent "test pattern-engine-code" --dry-run
---

# Pattern Engine: Code

## Purpose
Generate code using controlled pattern abstractions.

## Patterns Applied
- PATTERN-001: Role-Based Agent Framing
- PATTERN-002: Tool Invocation with Validation
- PATTERN-004: Multi-Step Reasoning Chain
- PATTERN-010: Iterative Refinement Loop

## Input Schema

```yaml
task: "Implement user authentication API"
language: "typescript"
context_files: ["src/config/auth.ts", "src/models/user.ts"]
constraints: ["no_plain_text_passwords", "use_jwt", "validate_inputs"]
pattern_id: "code-generation"
```

## Output Schema

```json
{
  "analysis": "Generated auth API with JWT tokens and input validation",
  "structured_output": {
    "code": "export async function login...",
    "tests": ["test('validates email'...)"],
    "schema": {"type": "object", "properties": {...}},
    "explanation": "Uses bcrypt for hashing, jwt for tokens",
    "confidence": 0.96,
    "tokens_used": 3420
  },
  "confidence": 0.96,
  "tokens_used": 3420
}
```

## Validation Rules
- Code must pass type checking
- Tests must cover primary paths
- Schema must validate
- Confidence ≥0.95
- RL score ≥95

## Usage

```bash
opencode run --agent "pattern-engine-code" --file task.yaml --pattern pattern-engine-code
```

## RL Scoring
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Schema Validity | 10% |
| Code Quality | 35% |
| Test Coverage | 25% |
| Token Efficiency | 5% |
| Confidence | 10% |

**Threshold: ≥95**
