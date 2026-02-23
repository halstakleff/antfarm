# Pre-Build: CI/CD & Environments

## Purpose

Build pipelines and multi-env setup.

## Step-by-Step

### Step 1: CI Pipeline
```bash
opencode run --agent "CI pipeline: lint, test, build, security scan" --file .github/workflows/ci.yml
```

### Step 2: Environments
```bash
opencode run --agent "setup environments: dev, staging, prod" --file infra/environments.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - .github/workflows/
RL_SCORE: 95
```
