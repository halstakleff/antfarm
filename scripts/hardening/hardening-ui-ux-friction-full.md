# Hardening: UI/UX Friction

## Purpose

User experience polish.

## Step-by-Step

### Step 1: Friction Audit
```bash
opencode run --agent "audit UX: clicks, confusion, delays" --file ux/friction-audit.md
```

### Step 2: Performance
```bash
opencode run --agent "UI performance: lazy loading, virtualization" --file ui/performance/
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - ux/friction-audit.md
RL_SCORE: 95
```
