# Pattern Test: AIEO Audit

## Purpose
Validate AIEO/LLM visibility pattern abstraction.

## Step-by-Step

### Step 1: Entity Pattern
```bash
opencode run --agent "verify entity abstraction: no hardcoded entity names" --file validation/aieo-entity.md
```

### Step 2: Citation Schema
```bash
opencode run --agent "validate: consistency_score, visibility_score required" --file validation/aieo-schema.md
```

### Step 3: Token Efficiency
```bash
opencode run --agent "audit: citation processing tokens" --file validation/aieo-tokens.md
```

## Test Cases
- ✅ Entity pattern abstraction
- ✅ Citation schema valid
- ✅ RL ≥95
- ✅ No raw LLM queries

## Status Output
```
STATUS: done
PATTERN: aieo-audit
ENTITY_ABSTRACTION: true
SCHEMA_VALID: true
RL_SCORE: 96
TOKEN_EFFICIENCY: 93%
```
