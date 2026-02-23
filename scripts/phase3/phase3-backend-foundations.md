# Phase 3: Backend Foundations

## Purpose

Build the domain layer before any feature code.

## Step-by-Step

### Step 1: Domain Models
```bash
opencode run --agent "create domain models: entities, value objects" --file src/domain/models.ts
```

### Step 2: Repository Interfaces
```bash
opencode run --agent "define repository interfaces: CRUD operations" --file src/domain/repositories.ts
```

### Step 3: Use Cases
```bash
opencode run --agent "implement use cases: business logic, orchestration" --file src/application/use-cases.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/domain/
  - src/application/
RL_SCORE: 95
NEXT_STEPS: Phase 3b Data Foundations
```
