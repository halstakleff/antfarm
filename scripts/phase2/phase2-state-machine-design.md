# Phase 2: State Machine Design

## Purpose

Define all state transitions before implementation. Prevents invalid states.

## Step-by-Step

### Step 1: State Identification
```bash
opencode run --agent "identify all states per entity: Draft, Pending, Active, Completed, etc." --file states/states.md
```

### Step 2: Transition Mapping
```bash
opencode run --agent "map valid transitions: Draft -> Pending, Pending -> Active, etc." --file states/transitions.md
opencode run --agent "define transition guards: conditions for allowed transitions" --file states/guards.md
```

### Step 3: State Diagram
```bash
opencode run --agent "create Mermaid state diagram" --file states/state-diagram.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - states/state-diagram.md
  - states/transitions.md
RL_SCORE: 95
NEXT_STEPS: Phase 2d - Concurrency
```
