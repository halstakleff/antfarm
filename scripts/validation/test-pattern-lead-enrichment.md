# Pattern Test: Lead Enrichment

## Purpose
Validate lead enrichment pattern abstraction.

## Step-by-Step

### Step 1: Data Pattern
```bash
opencode run --agent "verify enrichment pattern: no raw API queries" --file validation/lead-pattern.md
```

### Step 2: Output Schema
```bash
opencode run --agent "validate: enriched_data, sources, confidence" --file validation/lead-schema.md
```

### Step 3: Privacy Check
```bash
opencode run --agent "verify PII handling: sanitize sensitive data" --file validation/lead-privacy.md
```

## Test Cases
- ✅ Pattern abstraction
- ✅ Schema compliance
- ✅ PII sanitized
- ✅ RL ≥95

## Status Output
```
STATUS: done
PATTERN: lead-enrichment
ABSTRACTION: true
SCHEMA_VALID: true
PII_SAFE: true
RL_SCORE: 95
TOKEN_EFFICIENCY: 91%
```
