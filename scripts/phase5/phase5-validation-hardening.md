# Phase 5: Validation Hardening

## Purpose

Input validation, sanitization, injection prevention.

## Step-by-Step

### Step 1: Input Validation
```bash
opencode run --agent "strict validation: schemas, sanitization" --file src/validation/input.ts
```

### Step 2: Security Audit
```bash
opencode run --agent "security scan: OWASP, dependency vulnerabilities" --file .github/workflows/security.yml
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/validation/
RL_SCORE: 95
NEXT_STEPS: Phase 5b Data Integrity
```
