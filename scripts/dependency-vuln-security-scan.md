# Dependency Vulnerability Security Scan

## Purpose

Scan dependencies for CVEs.

## Step-by-Step

### Step 1: Audit
```bash
npm audit --audit-level=high
```

### Step 2: Fix
```bash
npm audit fix
```

## Status Output

```
STATUS: done
RL_SCORE: 97
```
