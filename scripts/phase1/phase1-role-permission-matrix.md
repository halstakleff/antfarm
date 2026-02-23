# Phase 1: Role & Permission Matrix

## Purpose

Define authorization model before code. Security-first permission design.

## Step-by-Step

### Step 1: Role Definition
```bash
opencode run --agent "define roles: Admin, Manager, User, Guest, etc. with permissions per resource" --file security/role-matrix.md
```

### Step 2: Resource Mapping
```bash
opencode run --agent "map CRUD operations to roles per resource" --file security/permission-matrix.md
```

### Step 3: Validation Rules
```bash
opencode run --agent "define validation rules: field-level, row-level, ownership checks" --file security/validation-rules.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - security/role-matrix.md
  - security/permission-matrix.md
RL_SCORE: 96
NEXT_STEPS: Phase 2 Design
```
