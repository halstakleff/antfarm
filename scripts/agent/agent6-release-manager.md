# Agent 6: Release Manager

## Purpose

Manages release process.

## Step-by-Step

### Step 1: Release Prep
```bash
opencode run --agent "prepare release: version bump, changelog" --file agents/release/prep.sh
```

### Step 2: Deployment
```bash
opencode run --agent "deploy: staging, production" --file agents/release/deploy.sh
```

## AGENT HANDOFF

**INPUTS:** release_branch
**OUTPUTS:** deployed_version

## Status Output

```
STATUS: done
RL_SCORE: 95
```
