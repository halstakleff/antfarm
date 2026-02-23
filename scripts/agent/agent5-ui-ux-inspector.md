# Agent 5: UI/UX Inspector

## Purpose

UI/UX quality checks.

## Step-by-Step

### Step 1: Visual Review
```bash
opencode run --agent "screenshot UI, check layout" --file agents/ui/screenshot.ts
```

### Step 2: Friction Audit
```bash
opencode run --agent "audit friction: clicks, confusion" --file agents/ui/friction.md
```

## AGENT HANDOFF

**INPUTS:** UI code
**OUTPUTS:** ui_report

## Status Output

```
STATUS: done
RL_SCORE: 94
```
