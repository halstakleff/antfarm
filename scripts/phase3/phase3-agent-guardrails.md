# Phase 3: Agent Guardrails

## Purpose

Safety boundaries for AI agents: scopes, checks, rollbacks.

## Step-by-Step

### Step 1: Scope Guardrails
```bash
opencode run --agent "define agent scopes: what files each agent can touch" --file .agent-scopes.yml
```

### Step 2: Safety Checks
```bash
opencode run --agent "pre-commit checks: secrets, tests, lint" --file .github/hooks/pre-commit
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - .agent-scopes.yml
RL_SCORE: 95
NEXT_STEPS: Phase 4 Build
```
