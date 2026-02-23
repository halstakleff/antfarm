# Pattern Test: Website Build

## Purpose
Validate website build pattern abstraction.

## Step-by-Step

### Step 1: Pattern Detection
```bash
opencode run --agent "scan for raw prompts: detect direct copy-paste" --file validation/website-scan.md
```

### Step 2: Component Schema
```bash
opencode run --agent "validate: components, copy_blocks, schema fields" --file validation/website-schema.md
```

### Step 3: Token Efficiency
```bash
opencode run --agent "audit tokens: measure pattern compression" --file validation/website-tokens.md
```

### Step 4: Safety Check
```bash
opencode run --agent "test injection: sanitize all user inputs" --file validation/website-safety.md
```

## Test Cases
- ✅ Pattern abstraction used
- ❌ No raw HTML/CSS copying
- ✅ RL score ≥95
- ✅ Schema compliance 100%

## Status Output
```
STATUS: done
PATTERN: website-build
ABSTRACTION_RATE: 100%
SCHEMA_VALID: true
RL_SCORE: 95
TOKEN_EFFICIENCY: 92%
```
