# Prompt Governance Rules

## Version 1.0.0

---

## Rule 1: No Ad-Hoc Prompt Writing

**MANDATORY**: All prompts must reference a Pattern_ID.

❌ **FORBIDDEN**:
```
"Write me some code that does..."
```

✅ **REQUIRED**:
```yaml
use_pattern: "PATTERN-001"
input:
  task: "authentication"
  language: "typescript"
```

---

## Rule 2: Schema Validation Required

**MANDATORY**: All outputs must validate against schema.

```javascript
validateSchema(output, pattern.output_schema);
```

❌ **FAILURE**: Missing required field  
✅ **PASS**: All fields present, types correct

---

## Rule 3: Prompt Logging Required

**MANDATORY**: All prompt usage logged in PROMPT_USAGE.md

```yaml
log_entry:
  timestamp: "2026-02-22T18:00:00Z"
  script: "hero-optimizer"
  pattern_id: "PATTERN-007"
  input_summary: "ecommerce, hero, 3 benefits"
  output_path: "website/sections/hero.md"
  rl_score: 96
  tokens_used: 2847
  refinement_count: 1
```

---

## Rule 4: Token Threshold Enforcement

**MANDATORY**: No prompt may exceed max tokens without justification.

| Prompt Type | Max Tokens | Justification Required |
|-------------|------------|----------------------|
| Simple | 2000 | No |
| Standard | 4000 | No |
| Complex | 8000 | Yes |
| Research | 16000 | Yes |

---

## Rule 5: Refinement Loop Support

**MANDATORY**: All prompts must support refinement.

```yaml
refinement_config:
  max_iterations: 3
  rl_threshold: 95
  loop_type: "ralph"
  abort_on_failure: true
```

---

## Rule 6: Version Tracking

**MANDATORY**: All prompts version tracked.

```yaml
pattern_version: "1.0.0"
last_updated: "2026-02-22"
changelog:
  - "v1.0.0: Initial release"
```

---

## Rule 7: No Raw Pattern Copying

**FORBIDDEN**: Copying raw prompt text from external sources.

❌ **VIOLATION**:  
- Verbatim copy of external prompt  
- Minor rewording of copyrighted text  
- Structural copying without abstraction

✅ **COMPLIANCE**:  
- Pattern abstraction only  
- Original implementation  
- Structural analysis, not copying

---

## Rule 8: Confidence Scoring

**MANDATORY**: All outputs include confidence score.

```yaml
output:
  confidence: 0.96  # 0-1
```

---

## Rule 9: Anti-Injection Sanitization

**MANDATORY**: All inputs sanitized.

```javascript
sanitizeInput(userInput);
```

❌ **FORBIDDEN**:
- `eval(input)`  
- Direct execution of user input  
- Unescaped variables in prompts

---

## Rule 10: Structured Output Only

**MANDATORY**: All outputs structured JSON.

```json
{
  "analysis": "concise reasoning",
  "structured_output": {...},
  "confidence": 0.96
}
```

---

## Enforcement

### Automatic Checks
- Schema validation on every output
- Token count on every invocation
- Pattern ID verification
- Confidence threshold check

### Manual Audits
- Monthly PROMPT_USAGE.md review
- Pattern library compliance check
- RL score distribution analysis

### Violation Handling
| Severity | Action |
|----------|--------|
| Minor | Warning logged |
| Major | Output blocked |
| Critical | Workflow halted |

---

## RL Scoring Integration

### Governance Compliance Weights

| Criterion | Weight |
|-----------|--------|
| Pattern ID Present | 10% |
| Schema Validation | 15% |
| Prompt Logged | 5% |
| Token Threshold | 5% |
| Version Tracked | 5% |
| No Raw Copying | 15% |
| Confidence Present | 5% |
| Anti-Injection | 10% |
| Structured Output | 10% |
| **TOTAL** | **85%** |

With functional criteria, total RL ≥95 required.
