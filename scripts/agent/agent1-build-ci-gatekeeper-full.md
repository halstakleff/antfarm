# Agent 1: Build/CI Gatekeeper

## Purpose

Enforces CI gates: tests, lint, security.

## Step-by-Step

### Step 1: Pre-Build Checks
```bash
opencode run --agent "run lint, typecheck, format" --file agents/gatekeeper/pre-build.sh
```

### Step 2: Gate Enforcement
```bash
opencode run --agent "enforce gates: must pass to proceed" --file agents/gatekeeper/enforce.md
```

## AGENT HANDOFF

**INPUTS:** PR changes
**OUTPUTS:** gate_status
**STOP CONDITION:** S0 failure

## Status Output

```
STATUS: done
RL_SCORE: 98
```
