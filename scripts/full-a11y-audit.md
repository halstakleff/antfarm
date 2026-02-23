# Full Accessibility Audit

## Purpose

WCAG compliance check.

## Step-by-Step

### Step 1: Automated Scan
```bash
opencode run --agent "scan: axe-core, lighthouse" --file a11y/scan.ts
```

### Step 2: Manual Checklist
```bash
opencode run --agent "check: keyboard nav, screen reader" --file a11y/manual.md
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
