# Pre-Build: Admin Panel Generator

## Purpose

Auto-generate admin interfaces from data models.

## Step-by-Step

### Step 1: CRUD Scaffolding
```bash
opencode run --agent "create admin CRUD: list view, detail view, edit form, delete" --file admin/crud-generator.ts
```

### Step 2: Permission Integration
```bash
opencode run --agent "admin respects RBAC: show/hide based on permissions" --file admin/permission-guard.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - admin generator
RL_SCORE: 94
```
