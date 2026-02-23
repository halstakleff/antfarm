# Pattern Test: SEO Audit

## Purpose
Validate SEO audit pattern abstraction.

## Step-by-Step

### Step 1: Pattern Compliance
```bash
opencode run --agent "verify pattern usage: no raw audit prompts" --file validation/seo-pattern.md
```

### Step 2: Output Schema
```bash
opencode run --agent "validate: issues, fixes, scores required" --file validation/seo-schema.md
```

### Step 3: Token Audit
```bash
opencode run --agent "measure efficiency: audit prompt size" --file validation/seo-tokens.md
```

## Test Cases
- ✅ Pattern template used
- ❌ Raw scraping commands = FAIL
- ✅ Structured output
- ✅ RL ≥95

## Status Output
```
STATUS: done
PATTERN: seo-audit
PATTERN_COMPLIANCE: true
SCHEMA_VALID: true
RL_SCORE: 97
TOKEN_EFFICIENCY: 95%
```
