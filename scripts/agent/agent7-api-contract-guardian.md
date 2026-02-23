# Agent 7: API Contract Guardian

## Purpose

Protects API contracts from breaking changes.

## Step-by-Step

### Step 1: Contract Comparison
```bash
opencode run --agent "compare OpenAPI specs: detect breaking changes" --file agents/api/contract-diff.ts
```

### Step 2: Breaking Change Detection
```bash
opencode run --agent "flag breaking changes: stop merge" --file agents/api/breaking.md
```

## AGENT HANDOFF

**INPUTS:** new_spec, old_spec
**OUTPUTS:** compatibility_report
**STOP CONDITION:** breaking change detected

## Status Output

```
STATUS: done
RL_SCORE: 98
```
