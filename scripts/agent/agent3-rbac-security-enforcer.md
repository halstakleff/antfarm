# Agent 3: RBAC Security Enforcer

## Purpose

Validates RBAC implementation.

## Step-by-Step

### Step 1: Permission Audit
```bash
opencode run --agent "audit every endpoint: permissions, roles" --file agents/security/rbac-audit.md
```

### Step 2: Violation Reporting
```bash
opencode run --agent "report violations: missing guards, over-permission" --file agents/security/violations.md
```

## AGENT HANDOFF

**INPUTS:** API routes
**OUTPUTS:** security_report
**STOP CONDITION:** S0 violation found

## Status Output

```
STATUS: done
RL_SCORE: 97
```
