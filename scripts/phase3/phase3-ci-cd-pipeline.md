# Phase 3: CI/CD Pipeline

## Purpose

Automated build, test, deploy pipeline.

## Step-by-Step

### Step 1: Build Job
```bash
opencode run --agent "GH Actions: install, lint, test, build" --file .github/workflows/build.yml
```

### Step 2: Deploy Job
```bash
opencode run --agent "deploy: staging, production, rollback" --file .github/workflows/deploy.yml
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - .github/workflows/
RL_SCORE: 95
NEXT_STEPS: Phase 3f Guardrails
```
