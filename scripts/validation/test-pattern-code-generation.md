# Pattern Test: Code Generation

## Purpose
Validate code generation pattern abstraction.

## Step-by-Step

### Step 1: Pattern Detection
```bash
opencode run --agent "scan for raw prompts: detect direct instruction copying" --file validation/code-scan.md
```

### Step 2: Schema Validation
```bash
opencode run --agent "validate output: code, tests, rl_score fields present" --file validation/code-schema.md
```

### Step 3: Token Audit
```bash
opencode run --agent "measure token efficiency: prompt vs pattern ratio" --file validation/code-tokens.md
```

### Step 4: Injection Test
```bash
opencode run --agent "fuzz inputs: attempt prompt injection, verify sanitization" --file validation/code-injection.md
```

## Test Cases
- ✅ Pattern template used
- ❌ Raw prompt detected = FAIL
- ✅ Schema valid
- ✅ RL score ≥95
- ✅ Token efficiency ≥90%

## Status Output
```
STATUS: done
PATTERN: code-generation
RAW_PROMPT_DETECTED: false
SCHEMA_VALID: true
RL_SCORE: 96
TOKEN_EFFICIENCY: 94%
INJECTION_RESISTANT: true
```
