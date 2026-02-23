# Code Generation Enforcer

## Purpose

Auto-generate boilerplate code.

## Step-by-Step

### Step 1: Template Definition
```bash
opencode run --agent "define code templates: CRUD, API, tests" --file generators/templates/
```

### Step 2: Generation
```bash
opencode run --agent "generate from templates" --file generators/run.ts
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
