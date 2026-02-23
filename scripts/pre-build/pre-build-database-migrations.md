# Pre-Build: Database & Migrations

## Purpose

Version-controlled schema with migration tooling.

## Step-by-Step

### Step 1: Migration Tool
```bash
opencode run --agent "setup migration tool: Flyway/Prisma/TypeORM migrations" --file migrations/structure.md
```

### Step 2: Initial Schema
```bash
opencode run --agent "create base tables: users, roles, migrations tracking" --file migrations/001_initial.sql
```

### Step 3: Rollback Strategy
```bash
opencode run --agent "define rollback: down migrations, backup before migrate" --file migrations/rollback.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - migration scripts
RL_SCORE: 95
```
