# Phase 4: Vertical Slice Build

## Purpose

End-to-end feature implementation: API → domain → persistence → UI.

## Step-by-Step

### Step 1: Feature Slice
```bash
opencode run --agent "implement full slice: controller, use case, repository, model" --file src/features/[feature]/
```

### Step 2: Integration
```bash
opencode run --agent "wire components: DI registration, route mapping" --file src/features/[feature]/module.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/features/
RL_SCORE: 95
NEXT_STEPS: Phase 4b Swarm
```
