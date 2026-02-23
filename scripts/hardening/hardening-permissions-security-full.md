# Hardening: Permissions & Security

## Purpose

Comprehensive security audit.

## Step-by-Step

### Step 1: Security Scan
```bash
opencode run --agent "security scan: dependencies, secrets, OWASP" --file .github/workflows/security-scan.yml
```

### Step 2: Permission Audit
```bash
opencode run --agent "audit permissions: every endpoint, every role" --file security/permission-audit.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - security/permission-audit.md
RL_SCORE: 95
```
