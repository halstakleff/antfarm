# Pattern Test: Sales Email

## Purpose
Validate sales email pattern abstraction.

## Step-by-Step

### Step 1: Template Pattern
```bash
opencode run --agent "verify template usage: no raw email copying" --file validation/email-pattern.md
```

### Step 2: Structure Schema
```bash
opencode run --agent "validate: subject, body, follow_up required" --file validation/email-schema.md
```

### Step 3: Tone Check
```bash
opencode run --agent "verify tone compliance: brand voice enforced" --file validation/email-tone.md
```

## Test Cases
- ✅ Pattern template
- ❌ No generic templates
- ✅ Schema valid
- ✅ RL ≥95

## Status Output
```
STATUS: done
PATTERN: sales-email
TEMPLATE_USED: true
SCHEMA_VALID: true
TONE_COMPLIANT: true
RL_SCORE: 96
TOKEN_EFFICIENCY: 94%
```
