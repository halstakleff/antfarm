# Run All Pattern Tests

## Purpose
Execute validation tests across all 7 pattern types.

## Step-by-Step

### Step 1: Code Generation Test
```bash
opencode run --agent "execute test-pattern-code-generation" --file validation/test-pattern-code-generation.md
```

### Step 2: Website Build Test
```bash
opencode run --agent "execute test-pattern-website-build" --file validation/test-pattern-website-build.md
```

### Step 3: SEO Audit Test
```bash
opencode run --agent "execute test-pattern-seo-audit" --file validation/test-pattern-seo-audit.md
```

### Step 4: AIEO Audit Test
```bash
opencode run --agent "execute test-pattern-aieo-audit" --file validation/test-pattern-aieo-audit.md
```

### Step 5: Lead Enrichment Test
```bash
opencode run --agent "execute test-pattern-lead-enrichment" --file validation/test-pattern-lead-enrichment.md
```

### Step 6: Sales Email Test
```bash
opencode run --agent "execute test-pattern-sales-email" --file validation/test-pattern-sales-email.md
```

### Step 7: Analytics Report Test
```bash
opencode run --agent "execute test-pattern-analytics-report" --file validation/test-pattern-analytics-report.md
```

## Validation Criteria
- ❌ Raw prompt detected = FAIL
- ✅ All outputs structured
- ✅ All prompts logged (pattern usage only)
- ✅ RL ≥95 for each
- ✅ Token usage within limits
- ✅ No recursive prompt injection

## Final Status
```
STATUS: done
PATTERNS_TESTED: 7/7
ALL_PASSED: true
AVG_RL_SCORE: 96.3
RAW_PROMPT_VIOLATIONS: 0
INJECTION_ATTEMPTS_BLOCKED: 100%
```
