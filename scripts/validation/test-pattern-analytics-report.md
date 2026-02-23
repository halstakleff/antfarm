# Pattern Test: Analytics Report

## Purpose
Validate analytics report pattern abstraction.

## Step-by-Step

### Step 1: Report Pattern
```bash
opencode run --agent "verify pattern: no raw metric dumping" --file validation/analytics-pattern.md
```

### Step 2: Structure Schema
```bash
opencode run --agent "validate: summary, insights, recommendations" --file validation/analytics-schema.md
```

### Step 3: Data Integrity
```bash
opencode run --agent "verify calculations: cross-check metrics" --file validation/analytics-integrity.md
```

## Test Cases
- ✅ Pattern abstraction
- ❌ No raw data dumps
- ✅ Schema compliance
- ✅ RL ≥95

## Status Output
```
STATUS: done
PATTERN: analytics-report
PATTERN_COMPLIANT: true
SCHEMA_VALID: true
DATA_INTEGRITY: 100%
RL_SCORE: 97
TOKEN_EFFICIENCY: 93%
```
