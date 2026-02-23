# Pre-Build: Workflow Engine

## Purpose

State machines and job orchestration.

## Step-by-Step

### Step 1: State Machine
```bash
opencode run --agent "implement state machine: states, transitions, guards" --file workflows/state-machine.ts
```

### Step 2: Workflow Runner
```bash
opencode run --agent "workflow execution: step orchestration, error handling, retry" --file workflows/runner.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - workflows/
RL_SCORE: 95
```
