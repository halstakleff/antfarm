# Controlled Prompt Pattern Infrastructure

## Purpose
Govern prompt usage across all agents. Prevent raw prompt copying. Enforce pattern abstraction. Standardize output.

---

## Pattern Abstraction Layers

### Level 0: Raw Prompt (FORBIDDEN)
❌ Never copy raw prompts between agents
❌ Never log full prompt content
❌ Never hardcode system instructions

### Level 1: Pattern Templates (REQUIRED)
✅ Use pattern abstractions
✅ Parameterized inputs
✅ Structured outputs
✅ Version controlled

### Level 2: Skill Wrappers (MANDATORY)
✅ All prompts wrapped in SKILL.md
✅ Input/output schemas enforced
✅ Side effects documented
✅ Self-test commands

---

## RL Scoring — Pattern Compliance

### New Criteria (added to RL rubric)

| Criterion | Weight | Threshold |
|-----------|--------|-----------|
| **Pattern Compliance** | 15% | Must use pattern templates |
| **Output Schema Validity** | 10% | JSON/YAML validation |
| **Constraint Adherence** | 10% | Follows input/output rules |
| **Token Efficiency** | 5% | No bloat, no duplication |
| **Previous Criteria** | 60% | SEO, AIEO, Conversion, Writing |
| **TOTAL** | **100%** | **≥95 required** |

### Pattern Compliance Check
```
PATTERN_COMPLIANCE_SCORE:
- Raw prompt detected: -50 points
- Missing schema: -30 points
- No template abstraction: -40 points
- Direct prompt injection: -100 points (FAIL)
```

---

## Pattern Library

### Code Generation Pattern
```yaml
pattern: code-generation
input:
  task: string
  language: string
  constraints: array
output:
  code: string
  tests: array
  rl_score: number
```

### Website Build Pattern
```yaml
pattern: website-build
input:
  page_type: string
  target_persona: string
  key_benefit: string
output:
  components: array
  copy_blocks: object
  schema: object
  rl_score: number
```

### SEO Audit Pattern
```yaml
pattern: seo-audit
input:
  url: string
  audit_type: string
output:
  issues: array
  fixes: array
  scores: object
  rl_score: number
```

### AIEO Audit Pattern
```yaml
pattern: aieo-audit
input:
  entity: string
  citations: array
output:
  consistency_score: number
  visibility_score: number
  recommendations: array
  rl_score: number
```

### Lead Enrichment Pattern
```yaml
pattern: lead-enrichment
input:
  contact: object
  enrichment_level: string
output:
  enriched_data: object
  sources: array
  confidence: number
  rl_score: number
```

### Sales Email Pattern
```yaml
pattern: sales-email
input:
  persona: string
  pain_point: string
  offer: string
output:
  subject: string
  body: string
  follow_up: array
  rl_score: number
```

### Analytics Report Pattern
```yaml
pattern: analytics-report
input:
  metrics: array
  timeframe: string
output:
  summary: string
  insights: array
  recommendations: array
  rl_score: number
```

---

## Pattern Enforcement Rules

### Rule 1: No Raw Prompt Copying
```javascript
// ❌ FORBIDDEN
copyPrompt(fromAgent, toAgent);

// ✅ REQUIRED
usePattern('code-generation', {
  task: 'build API',
  language: 'typescript'
});
```

### Rule 2: Schema Validation
```javascript
// ✅ All outputs must validate
validateSchema(output, pattern.output_schema);
```

### Rule 3: Prompt Logging
```javascript
// ✅ Log pattern usage, not content
logPatternUsage({
  pattern: 'code-generation',
  timestamp: Date.now(),
  rl_score: 96
});
```

### Rule 4: Token Budget
```javascript
// ✅ Token efficiency enforced
if (tokenUsage > maxTokens * 0.9) {
  triggerRefactor();
}
```

### Rule 5: Anti-Injection
```javascript
// ✅ Sanitize all inputs
sanitizeInput(userInput);
// ❌ Never: eval(input) or direct execution
```

---

## Validation Tests

### Test 1: Pattern Detection
- Scan for raw prompt strings
- Verify pattern template usage
- Check for hardcoded instructions

### Test 2: Schema Compliance
- Validate all outputs against schemas
- Check required fields present
- Type checking

### Test 3: Token Audit
- Measure prompt efficiency
- Detect duplication
- Calculate compression ratio

### Test 4: Injection Resistance
- Fuzz test inputs
- Attempt prompt injection
- Verify sanitization

---

## Governance Dashboard

```yaml
PATTERN_METRICS:
  patterns_used: 7
  pattern_abstraction_rate: 100%
  raw_prompt_violations: 0
  schema_validation_pass_rate: 100%
  average_rl_score: 96.4
  token_efficiency: 94%
```

---

## Failure Modes

### If RL < 95:
1. Run Ralph loop on failing component
2. Refactor to proper pattern
3. Re-validate schema
4. Re-run test suite
5. Confirm RL ≥95

### If Raw Prompt Detected:
1. Block execution
2. Log violation
3. Require pattern abstraction
4. Notify operator

### If Schema Invalid:
1. Halt output
2. Return validation errors
3. Fix schema compliance
4. Re-process
